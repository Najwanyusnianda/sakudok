//lib/features/documents/presentation/widgets/document_form/document_basic_info_section.dart
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class DocumentBasicInfoSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<List<String>> onTagsChanged;
  final Map<String, dynamic>? extractedData;
  final bool isAutoPopulated;

  const DocumentBasicInfoSection({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.tagsController,
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.onTagsChanged,
    this.extractedData,
    this.isAutoPopulated = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer.withOpacity(0.3), 
                colorScheme.secondaryContainer.withOpacity(0.3)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Icon(
                  isAutoPopulated ? Icons.auto_awesome : Icons.edit,
                  color: colorScheme.onPrimary,
                  size: AppTheme.iconMd,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step 3: Verify Information',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceXs),
                    Text(
                      isAutoPopulated 
                        ? 'Review and edit the auto-populated information'
                        : 'Fill in the basic document information',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceLg),

        // Auto-population Status
        if (isAutoPopulated) _buildAutoPopulationStatus(context),

        // Title Field
        _buildEnhancedField(
          context: context,
          controller: titleController,
          label: 'Document Title',
          icon: Icons.title,
          hint: 'Give your document a clear title',
          isRequired: true,
          isAutoPopulated: extractedData?.containsKey('title') == true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Title is required';
            }
            if (value.length < 3) {
              return 'Title must be at least 3 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: AppTheme.spaceLg),

        // Description Field
        _buildEnhancedField(
          context: context,
          controller: descriptionController,
          label: 'Description',
          icon: Icons.description,
          hint: 'Add any additional notes or details',
          isRequired: false,
          maxLines: 3,
          maxLength: 500,
          isAutoPopulated: extractedData?.containsKey('description') == true,
        ),
        const SizedBox(height: AppTheme.spaceLg),

        // Tags Field
        _buildTagsField(context),
        const SizedBox(height: AppTheme.spaceLg),

        // Favorite Toggle
        _buildFavoriteToggle(context),
        const SizedBox(height: AppTheme.spaceMd),

        // Quick Tips
        _buildQuickTips(context),
      ],
    );
  }

  Widget _buildAutoPopulationStatus(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spaceLg),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green.shade600,
            size: AppTheme.iconSm,
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auto-populated from OCR',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  'Information extracted automatically. Please review and edit as needed.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    required bool isRequired,
    bool isAutoPopulated = false,
    int maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field Label
        Row(
          children: [
            Icon(icon, size: AppTheme.iconXs, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: AppTheme.spaceSm),
            Text(
              label + (isRequired ? ' *' : ''),
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            if (isAutoPopulated) ...[
              const SizedBox(width: AppTheme.spaceSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceXs, 
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXs),
                ),
                child: Text(
                  'Auto-filled',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppTheme.spaceSm),
        
        // Text Field
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: isAutoPopulated 
              ? Colors.green.shade50 
              : colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.all(AppTheme.spaceMd),
            prefixIcon: Container(
              margin: const EdgeInsets.all(AppTheme.spaceSm),
              padding: const EdgeInsets.all(AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: isAutoPopulated 
                  ? Colors.green.shade100
                  : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Icon(
                icon, 
                size: AppTheme.iconXs, 
                color: isAutoPopulated 
                  ? Colors.green.shade700
                  : colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          textCapitalization: maxLines == 1 
            ? TextCapitalization.words 
            : TextCapitalization.sentences,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildTagsField(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tag, size: AppTheme.iconXs, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: AppTheme.spaceSm),
            Text(
              'Tags',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceSm),
        
        TextFormField(
          controller: tagsController,
          decoration: InputDecoration(
            hintText: 'personal, important, work, family',
            helperText: 'Separate tags with commas for better organization',
            helperStyle: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            prefixIcon: Container(
              margin: const EdgeInsets.all(AppTheme.spaceSm),
              padding: const EdgeInsets.all(AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Icon(
                Icons.tag, 
                size: AppTheme.iconXs, 
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            final tags = value
                .split(',')
                .map((tag) => tag.trim())
                .where((tag) => tag.isNotEmpty)
                .toList();
            onTagsChanged(tags);
          },
        ),
      ],
    );
  }

  Widget _buildFavoriteToggle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: colorScheme.outline),
        color: colorScheme.surface,
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd, 
          vertical: AppTheme.spaceSm,
        ),
        title: Text(
          'Mark as Favorite',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Quick access in favorites section',
          style: theme.textTheme.bodySmall,
        ),
        secondary: Container(
          padding: const EdgeInsets.all(AppTheme.spaceSm),
          decoration: BoxDecoration(
            color: isFavorite ? Colors.amber.shade100 : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
          child: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: isFavorite ? Colors.amber.shade700 : colorScheme.onSurfaceVariant,
            size: AppTheme.iconSm,
          ),
        ),
        value: isFavorite,
        onChanged: onFavoriteChanged,
        activeColor: Colors.amber.shade600,
      ),
    );
  }

  Widget _buildQuickTips(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline, 
                color: colorScheme.onSecondaryContainer,
                size: AppTheme.iconSm,
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Text(
                'Quick Tips',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          ...([
            'Use descriptive titles to make documents easier to find',
            'Add relevant tags for better organization and search',
            'Review auto-filled information for accuracy',
            'Mark important documents as favorites',
          ]).map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                Expanded(
                  child: Text(
                    tip,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSecondaryContainer.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
