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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 16,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white70),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            onFilterChanged(filter);
          }
        },
        backgroundColor: Colors.white.withOpacity(0.2),
        selectedColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        checkmarkColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
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
        return Icons.credit_card;
      case DocumentFilter.documents:
        return Icons.description;
    }
  }
}
