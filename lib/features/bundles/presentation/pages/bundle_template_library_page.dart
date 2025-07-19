import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_providers.dart';
import '../widgets/bundle_template_card.dart';
import 'create_edit_bundle_template_page.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';

class BundleTemplateLibraryPage extends ConsumerWidget {
  const BundleTemplateLibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTemplatesAsync = ref.watch(userTemplatesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Template Library'),
        elevation: 0,
      ),
      body: userTemplatesAsync.when(
        data: (templates) => templates.isEmpty
            ? _buildEmptyState(context)
            : _buildTemplateList(context, ref, templates),
        loading: () => const LoadingWidget(message: 'Loading your templates...'),
        error: (error, stack) => ErrorStateWidget(
          message: 'Failed to load templates.',
          error: error.toString(),
          onRetry: () => ref.invalidate(userTemplatesNotifierProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToCreateTemplate(context),
        icon: const Icon(Icons.add),
        label: const Text('Create Template'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'No Templates Yet',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Create your own custom templates to speed up bundle creation',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _navigateToCreateTemplate(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Your First Template'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateList(BuildContext context, WidgetRef ref, List templates) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.bookmark,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your Custom Templates',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final template = templates[index];
                return BundleUserTemplateCard(
                  template: template,
                  onTap: () => _editTemplate(context, template),
                  onDelete: () => _confirmDeleteTemplate(context, ref, template),
                );
              },
              childCount: templates.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 80), // Space for FAB
        ),
      ],
    );
  }

  void _navigateToCreateTemplate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateEditTemplatePage(),
      ),
    );
  }

  void _editTemplate(BuildContext context, template) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateEditTemplatePage(template: template),
      ),
    );
  }

  void _confirmDeleteTemplate(BuildContext context, WidgetRef ref, template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Template'),
        content: Text('Are you sure you want to delete "${template.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await ref
                  .read(userTemplatesNotifierProvider.notifier)
                  .deleteUserTemplate(template.id);
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Template deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
