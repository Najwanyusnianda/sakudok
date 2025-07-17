import 'package:flutter/material.dart';
import '../../../domain/entities/document_type.dart'; // Adjust import path as needed
import '../../pages/document_list_page.dart'; // Adjust import path for DocumentFilter

class FilterChipsWidget extends StatelessWidget {
  final DocumentFilter selectedFilter;
  final ValueChanged<DocumentFilter> onFilterChanged;

  const FilterChipsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12.0), // Adjusted padding
      child: Row(
        children: DocumentFilter.values.map((filter) {
          return _buildFilterChip(
            context: context,
            label: _getFilterLabel(filter),
            icon: _getFilterIcon(filter),
            filter: filter,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required IconData icon,
    required DocumentFilter filter,
  }) {
    final isSelected = selectedFilter == filter;
    // --- IMPROVEMENT: Use theme colors for consistent styling ---
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Define colors for selected and unselected states based on the theme
    final selectedColor = colorScheme.primaryContainer;
    final unselectedColor = colorScheme.surfaceContainerHighest;
    final selectedContentColor = colorScheme.onPrimaryContainer;
    final unselectedContentColor = colorScheme.onSurfaceVariant;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        avatar: Icon(
          icon,
          size: 18,
          // Use theme-aware colors for the icon
          color: isSelected ? selectedContentColor : unselectedContentColor,
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            onFilterChanged(filter);
          }
        },
        // --- FIX: Use theme colors for background ---
        backgroundColor: unselectedColor,
        selectedColor: selectedColor,
        labelStyle: TextStyle(
          // --- FIX: Use theme colors for text ---
          color: isSelected ? selectedContentColor : unselectedContentColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
        // The checkmark is often redundant when background color changes.
        // Set to transparent to hide it for a cleaner look.
        checkmarkColor: Colors.transparent,
        side: BorderSide(
          color: isSelected ? colorScheme.primary.withOpacity(0.5) : Colors.transparent,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  String _getFilterLabel(DocumentFilter filter) {
    switch (filter) {
      case DocumentFilter.all:
        return 'All';
      case DocumentFilter.favorites:
        return 'Favorites';
      case DocumentFilter.expiring:
        return 'Expiring';
      case DocumentFilter.cards:
        return 'Cards';
      case DocumentFilter.documents:
        return 'Documents';
    }
  }

  IconData _getFilterIcon(DocumentFilter filter) {
    switch (filter) {
      case DocumentFilter.all:
        return Icons.folder_outlined;
      case DocumentFilter.favorites:
        return Icons.star_outline;
      case DocumentFilter.expiring:
        return Icons.warning_amber_outlined;
      case DocumentFilter.cards:
        return Icons.credit_card_outlined;
      case DocumentFilter.documents:
        return Icons.description_outlined;
    }
  }
}