// lib/features/bundles/presentation/pages/bundle_main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle.dart';
import '../../domain/entities/bundle_template.dart';
import '../providers/bundle_providers.dart';
import '../widgets/bundle_card.dart';
import '../widgets/bundle_template_selector.dart';

class BundleMainPage extends ConsumerStatefulWidget {
  const BundleMainPage({super.key});

  @override
  ConsumerState<BundleMainPage> createState() => _BundleMainPageState();
}

class _BundleMainPageState extends ConsumerState<BundleMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Bundles'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.folder), text: 'My Bundles'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Suggestions'),
            Tab(icon: Icon(Icons.content_copy), text: 'Templates'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => _showStatistics(context),
            tooltip: 'Statistics',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyBundlesTab(),
          _buildSuggestionsTab(),
          _buildTemplatesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateBundleOptions(context),
        icon: const Icon(Icons.add),
        label: const Text('New Bundle'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildMyBundlesTab() {
    final bundlesAsync = ref.watch(bundlesNotifierProvider);

    return bundlesAsync.when(
      data: (bundles) {
        if (bundles.isEmpty) {
          return _buildEmptyState(
            icon: Icons.folder_open,
            title: 'No Bundles Yet',
            subtitle: 'Create your first smart bundle to organize related documents',
            actionText: 'Create Bundle',
            onAction: () => _showCreateBundleOptions(context),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.read(bundlesNotifierProvider.notifier).loadBundles();
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: bundles.length,
            itemBuilder: (context, index) {
              final bundle = bundles[index];
              return BundleCard(
                bundle: bundle,
                onTap: () => _openBundle(bundle),
                onEdit: () => _editBundle(bundle),
                onDelete: () => _deleteBundle(bundle),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(
        'Failed to load bundles',
        () => ref.read(bundlesNotifierProvider.notifier).loadBundles(),
      ),
    );
  }

  Widget _buildSuggestionsTab() {
    final suggestionsAsync = ref.watch(suggestedBundlesProvider);

    return suggestionsAsync.when(
      data: (suggestions) {
        if (suggestions.isEmpty) {
          return _buildEmptyState(
            icon: Icons.lightbulb_outline,
            title: 'No Suggestions Available',
            subtitle: 'Add more documents to get smart bundle suggestions based on patterns and relationships',
            actionText: 'Go to Documents',
            onAction: () {
              // Navigate to documents page
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.auto_awesome, color: Colors.purple),
                title: Text(suggestion.name),
                subtitle: Text(suggestion.description ?? ''),
                trailing: ElevatedButton(
                  onPressed: () => _createBundleFromSuggestion(suggestion),
                  child: const Text('Create'),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(
        'Failed to load suggestions',
        () => ref.refresh(suggestedBundlesProvider),
      ),
    );
  }

  Widget _buildTemplatesTab() {
    final templatesAsync = ref.watch(bundleTemplatesProvider);

    return templatesAsync.when(
      data: (templates) {
        // Group templates by category
        final groupedTemplates = <String, List<BundleTemplate>>{};
        for (final template in templates) {
          groupedTemplates.putIfAbsent(template.category, () => []).add(template);
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: groupedTemplates.entries.map((entry) {
            return _buildTemplateCategory(entry.key, entry.value);
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(
        'Failed to load templates',
        () => ref.refresh(bundleTemplatesProvider),
      ),
    );
  }

  Widget _buildTemplateCategory(String category, List<BundleTemplate> templates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...templates.map((template) => Card(
          child: ListTile(
            leading: Icon(_getTemplateIcon(template.icon)),
            title: Text(template.name),
            subtitle: Text(template.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (template.isPopular)
                  const Chip(
                    label: Text('Popular', style: TextStyle(fontSize: 10)),
                    backgroundColor: Colors.green,
                  ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _createBundleFromTemplate(template),
                  child: const Text('Use'),
                ),
              ],
            ),
          ),
        )),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add),
              label: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  IconData _getTemplateIcon(String iconName) {
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'flight':
        return Icons.flight;
      case 'school':
        return Icons.school;
      case 'account_balance':
        return Icons.account_balance;
      case 'workspace_premium':
        return Icons.workspace_premium;
      default:
        return Icons.folder;
    }
  }

  void _showCreateBundleOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create Empty Bundle'),
            subtitle: const Text('Start with an empty bundle and add documents manually'),
            onTap: () {
              Navigator.pop(context);
              _createEmptyBundle();
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_awesome),
            title: const Text('Use Smart Template'),
            subtitle: const Text('Choose from pre-configured bundle templates'),
            onTap: () {
              Navigator.pop(context);
              _showTemplateSelector();
            },
          ),
        ],
      ),
    );
  }

  void _showTemplateSelector() {
    showDialog(
      context: context,
      builder: (context) => BundleTemplateSelector(
        onTemplateSelected: (template) {
          Navigator.pop(context);
          _createBundleFromTemplate(template);
        },
      ),
    );
  }

  void _createEmptyBundle() {
    // TODO: Show bundle creation dialog
    // For now, create a simple bundle
    final bundle = Bundle(
      id: '0',
      name: 'New Bundle',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    ref.read(bundlesNotifierProvider.notifier).createBundle(bundle);
  }

  void _createBundleFromTemplate(BundleTemplate template) {
    // TODO: Show bundle name input dialog
    ref.read(bundlesNotifierProvider.notifier).createBundleFromTemplate(
      template.id,
      template.name,
    );
  }

  void _createBundleFromSuggestion(Bundle suggestion) {
    ref.read(bundlesNotifierProvider.notifier).createBundle(suggestion);
  }

  void _openBundle(Bundle bundle) {
    // TODO: Navigate to bundle detail page
  }

  void _editBundle(Bundle bundle) {
    // TODO: Show edit bundle dialog
  }

  void _deleteBundle(Bundle bundle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bundle'),
        content: Text('Are you sure you want to delete "${bundle.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement delete functionality
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showStatistics(BuildContext context) {
    final statsAsync = ref.read(bundleStatisticsProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bundle Statistics'),
        content: FutureBuilder(
          future: statsAsync.future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return const Text('Failed to load statistics');
            }
            
            final stats = snapshot.data as Map<String, int>;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatRow('Total Bundles', stats['total'] ?? 0),
                _buildStatRow('Complete', stats['complete'] ?? 0),
                _buildStatRow('Incomplete', stats['incomplete'] ?? 0),
                _buildStatRow('Smart Bundles', stats['smart'] ?? 0),
                _buildStatRow('Manual Bundles', stats['manual'] ?? 0),
                _buildStatRow('Template Bundles', stats['template'] ?? 0),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
        title: const Text('Bundle Dokumen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Bundle Saya'),
            Tab(text: 'Template'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyBundlesTab(),
          _buildTemplateLibraryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement create custom bundle
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur bundle akan segera hadir!'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMyBundlesTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Belum ada bundle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Buat bundle untuk mengorganisir\ndokumen Anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateLibraryTab() {
    final templates = [
      {
        'title': 'Lamaran Kerja',
        'description': 'KTP, Ijazah, CV, Transkrip',
        'icon': Icons.work,
      },
      {
        'title': 'Pendaftaran Beasiswa',
        'description': 'KK, Transkrip, Sertifikat',
        'icon': Icons.school,
      },
      {
        'title': 'Administrasi Pernikahan',
        'description': 'KTP, Akta Lahir, KK',
        'icon': Icons.favorite,
      },
      {
        'title': 'Perpanjangan SIM',
        'description': 'SIM, KTP',
        'icon': Icons.drive_eta,
      },
      {
        'title': 'Pembuatan Paspor',
        'description': 'KTP, KK',
        'icon': Icons.flight,
      },
      {
        'title': 'Pendaftaran BPJS',
        'description': 'KTP, KK',
        'icon': Icons.local_hospital,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return Card(
          child: ListTile(
            leading: Icon(
              template['icon'] as IconData,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              template['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(template['description'] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Template "${template['title']}" akan segera tersedia!',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
