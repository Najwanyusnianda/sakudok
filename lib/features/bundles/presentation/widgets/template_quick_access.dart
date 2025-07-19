// lib/features/bundles/presentation/widgets/template_quick_access.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_template.dart';

class TemplateQuickAccess extends StatelessWidget {
  final Function(BundleTemplate) onTemplateSelected;
  final VoidCallback onViewAllTemplates;

  const TemplateQuickAccess({
    super.key,
    required this.onTemplateSelected,
    required this.onViewAllTemplates,
  });

  @override
  Widget build(BuildContext context) {
    final popularTemplates = _getPopularTemplates();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Separator
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '— Or, accelerate with a template —',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        
        // Quick access chips
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularTemplates.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final template = popularTemplates[index];
              return _buildTemplateChip(context, template);
            },
          ),
        ),
        const SizedBox(height: 16),
        
        // View all templates button
        Center(
          child: OutlinedButton.icon(
            onPressed: onViewAllTemplates,
            icon: const Icon(Icons.content_copy_outlined, size: 18),
            label: const Text('View All Templates'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateChip(BuildContext context, BundleTemplate template) {
    return ActionChip(
      label: Text(
        template.name,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      avatar: Icon(
        _getIconForTemplate(template.id),
        size: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      side: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
      onPressed: () => onTemplateSelected(template),
    );
  }

  List<BundleTemplate> _getPopularTemplates() {
    return BundleTemplates.defaultTemplates.take(4).toList();
  }

  IconData _getIconForTemplate(String templateId) {
    switch (templateId) {
      case 'job_application':
        return Icons.work_outline;
      case 'scholarship':
        return Icons.school_outlined;
      case 'mortgage':
        return Icons.home_outlined;
      case 'visa_application':
        return Icons.flight_outlined;
      case 'business_registration':
        return Icons.business_outlined;
      default:
        return Icons.folder_outlined;
    }
  }
}
