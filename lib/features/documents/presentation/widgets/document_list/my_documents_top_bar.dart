// lib/features/documents/presentation/widgets/document_list/my_documents_top_bar.dart
import 'package:flutter/material.dart';

class MyDocumentsTopBar extends StatelessWidget {
  final VoidCallback onFilterPressed;
  final VoidCallback onSortPressed;
  final VoidCallback onSearchPressed;
  final bool isSearchActive;
  final bool hasActiveFilter;

  const MyDocumentsTopBar({
    super.key,
    required this.onFilterPressed,
    required this.onSortPressed,
    required this.onSearchPressed,
    this.isSearchActive = false,
    this.hasActiveFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              // Filter Icon (Left)
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: onFilterPressed,
                    tooltip: 'Filter documents',
                  ),
                  // Active filter indicator
                  if (hasActiveFilter)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              
              // Title (Center)
              Expanded(
                child: Text(
                  'My Documents',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              
              // Right Icons (Sort and Search)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sort Icon
                  IconButton(
                    icon: const Icon(
                      Icons.sort,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: onSortPressed,
                    tooltip: 'Sort documents',
                  ),
                  
                  // Search Icon
                  IconButton(
                    icon: Icon(
                      isSearchActive ? Icons.close : Icons.search,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: onSearchPressed,
                    tooltip: isSearchActive ? 'Close search' : 'Search documents',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
