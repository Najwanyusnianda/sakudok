// lib/features/bundles/presentation/widgets/bundle_template_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/bundle_template.dart';
import '../../domain/entities/bundle_user_template.dart';
import '../providers/bundle_providers.dart';

class BundleTemplateSelector extends ConsumerWidget {
  final Function(BundleTemplate) onTemplateSelected;
  final Function(BundleUserTemplate)? onUserTemplateSelected;

  const BundleTemplateSelector({
    super.key,
    required this.onTemplateSelected,
    this.onUserTemplateSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(bundleTemplatesProvider);
    final userTemplatesAsync = ref.watch(userTemplatesProvider);

    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'Choose Bundle Template',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Start with a template to speed up bundle creation. Choose from built-in templates or your custom ones.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 20),

            // Templates content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Templates Section
                    userTemplatesAsync.when(
                      data: (userTemplates) => userTemplates.isNotEmpty
                          ? _buildUserTemplatesSection(context, userTemplates)
                          : const SizedBox.shrink(),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    
                    // Built-in Templates Section
                    templatesAsync.when(
                      data: (templates) => _buildBuiltInTemplatesSection(context, templates),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text('Failed to load templates'),
                            TextButton(
                              onPressed: () => ref.refresh(bundleTemplatesProvider),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTemplatesSection(BuildContext context, List<BundleUserTemplate> userTemplates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Templates Header
        Row(
          children: [
            Icon(Icons.bookmark, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Text(
              'My Templates',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Your custom templates',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        
        // User Templates List
        ...userTemplates.map((template) => _buildUserTemplateCard(context, template)),
        
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBuiltInTemplatesSection(BuildContext context, List<BundleTemplate> templates) {
    // Group templates by category
    final groupedTemplates = <String, List<BundleTemplate>>{};
    for (final template in templates) {
      groupedTemplates.putIfAbsent(template.category, () => []).add(template);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Built-in Templates Header
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.purple, size: 20),
            const SizedBox(width: 8),
            Text(
              'Built-in Templates',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Pre-configured templates for common use cases',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        
        // Categories
        ...groupedTemplates.entries.map((entry) {
          return _buildCategorySection(context, entry.key, entry.value);
        }).toList(),
      ],
    );
  }

  Widget _buildUserTemplateCard(BuildContext context, BundleUserTemplate template) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (onUserTemplateSelected != null) {
            onUserTemplateSelected!(template);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.bookmark,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  template.name,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'My Template',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (template.description.isNotEmpty)
                            Text(
                              template.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Requirements
                if (template.requirements.isNotEmpty) ...[
                  Text(
                    'Document Requirements:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: template.requirements.map((requirement) {
                      return Chip(
                        label: Text(
                          requirement.name,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        side: BorderSide(color: Colors.blue.withOpacity(0.3)),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String category, List<BundleTemplate> templates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        
        // Templates in this category
        ...templates.map((template) => _buildTemplateCard(context, template)),
        
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTemplateCard(BuildContext context, BundleTemplate template) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onTemplateSelected(template),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and name
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconData(template.icon),
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              template.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (template.isPopular) ...[
                              const SizedBox(width: 8),
                              Chip(
                                label: const Text(
                                  'Popular',
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          template.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Required documents
              _buildDocumentTypesList(context, 'Required Documents', template.requiredDocumentTypes, Colors.red),
              
              // Optional documents (if any)
              if (template.optionalDocumentTypes.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildDocumentTypesList(context, 'Optional Documents', template.optionalDocumentTypes, Colors.orange),
              ],
              
              // Use cases
              if (template.useCases.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Use Cases:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  template.useCases.join(' • '),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentTypesList(BuildContext context, String title, List<String> types, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: types.map((type) {
            return Chip(
              label: Text(
                type.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  color: HSLColor.fromColor(color).withLightness(0.2).toColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: color.withOpacity(0.1),
              side: BorderSide(color: color.withOpacity(0.3)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
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
}
