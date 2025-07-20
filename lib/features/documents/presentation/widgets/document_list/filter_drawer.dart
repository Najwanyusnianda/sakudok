// lib/features/documents/presentation/widgets/document_list/filter_drawer.dart
import 'package:flutter/material.dart';
import '../../pages/document_list_page.dart'; // Adjust import path for DocumentFilter

class FilterDrawer extends StatelessWidget {
  final DocumentFilter selectedFilter;
  final ValueChanged<DocumentFilter> onFilterChanged;

  const FilterDrawer({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.filter_list_rounded,
                  color: theme.colorScheme.onPrimary,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'Filter Documents',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Choose how to view your documents',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Map each filter option to a ListTile
          ...DocumentFilter.values.map((filter) {
            final isSelected = selectedFilter == filter;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? theme.colorScheme.primaryContainer.withOpacity(0.3) : null,
              ),
              child: ListTile(
                leading: Icon(
                  _getFilterIcon(filter),
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  _getFilterLabel(filter),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  _getFilterDescription(filter),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  // When a filter is tapped, update the state
                  onFilterChanged(filter);
                  // And close the drawer
                  Navigator.pop(context);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  String _getFilterLabel(DocumentFilter filter) {
    switch (filter) {
      case DocumentFilter.all:
        return 'All Documents';
      case DocumentFilter.favorites:
        return 'Favorites';
      case DocumentFilter.expiring:
        return 'Expiring Soon';
      case DocumentFilter.cards:
        return 'Cards';
      case DocumentFilter.documents:
        return 'Documents';
    }
  }

  String _getFilterDescription(DocumentFilter filter) {
    switch (filter) {
      case DocumentFilter.all:
        return 'View all your documents';
      case DocumentFilter.favorites:
        return 'Your starred documents';
      case DocumentFilter.expiring:
        return 'Documents expiring within 60 days';
      case DocumentFilter.cards:
        return 'ID cards, licenses, and passports';
      case DocumentFilter.documents:
        return 'Certificates, contracts, and papers';
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
