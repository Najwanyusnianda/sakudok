// lib/features/documents/presentation/widgets/document_list/document_sliver_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/document_providers.dart'; // Adjust import path
import '../../pages/document_list_page.dart'; // Adjust import path for DocumentFilter

class DocumentSliverAppBar extends ConsumerWidget {
  final DocumentFilter selectedFilter;
  final ValueChanged<DocumentFilter> onFilterChanged;
  final VoidCallback onSortTap;
  final bool isSearchMode;
  final VoidCallback onSearchToggle;

  const DocumentSliverAppBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSortTap,
    this.isSearchMode = false,
    required this.onSearchToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: isSearchMode ? 140.0 : 60.0,
      floating: true,
      pinned: true,
      snap: true,
      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.0),
      foregroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            if (selectedFilter != DocumentFilter.all)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                ),
              ),
          ],
        ),
      ),
      title: const Text('My Documents'),
      actions: [
        IconButton(
          icon: Icon(isSearchMode ? Icons.close : Icons.search),
          onPressed: () {
            onSearchToggle();
            if (!isSearchMode) {
              // Clear search when closing search mode
              ref.read(searchQueryProvider.notifier).state = '';
            }
          },
        ),
        if (!isSearchMode)
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: onSortTap,
          ),
      ],
      bottom: isSearchMode ? PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            autofocus: true,
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
      ) : null,
    );
  }
}
