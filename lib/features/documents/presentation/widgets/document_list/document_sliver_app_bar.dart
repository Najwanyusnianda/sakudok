import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_providers.dart'; // Adjust import path
import 'filter_chips_widget.dart';
import '../../pages/document_list_page.dart'; // Adjust import path for DocumentFilter

class DocumentSliverAppBar extends ConsumerWidget {
  final DocumentFilter selectedFilter;
  final ValueChanged<DocumentFilter> onFilterChanged;
  final VoidCallback onSortTap;

  const DocumentSliverAppBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 180.0, // Adjusted height
      floating: true,
      pinned: true,
      snap: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      title: const Text('My Documents'),
      actions: [
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: onSortTap,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(110.0), // Height for search + filters
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search documents...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (value) =>
                    ref.read(searchQueryProvider.notifier).state = value,
              ),
            ),
            const SizedBox(height: 16),
            // Filter Chips
            FilterChipsWidget(
              selectedFilter: selectedFilter,
              onFilterChanged: onFilterChanged,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
