import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../providers/document_providers.dart';
import '../widgets/document_card.dart';
import 'add_edit_document_page.dart';
import 'quick_save_document_page.dart';
import 'edit_document_smart_features_page.dart';
import 'document_viewer_page.dart';
import '../widgets/document_capture/document_source_bottom_sheet.dart';
import '../../domain/entities/document_type.dart';

enum DocumentFilter { all, favorites, expiring, cards, documents }
enum SortOption { dateUpdated, dateCreated, title, type }

class DocumentListPage extends ConsumerStatefulWidget {
  const DocumentListPage({super.key});

  @override
  ConsumerState<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends ConsumerState<DocumentListPage> 
    with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;
  
  DocumentFilter _selectedFilter = DocumentFilter.all;
  SortOption _selectedSort = SortOption.dateUpdated;
  bool _isAscending = false;
  
  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );
    
    _scrollController.addListener(_onScroll);
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 400 && !_showScrollToTop) {
      setState(() {
        _showScrollToTop = true;
      });
    } else if (_scrollController.offset <= 400 && _showScrollToTop) {
      setState(() {
        _showScrollToTop = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final documents = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(searchResultsProvider);
          await ref.read(documentsNotifierProvider.notifier).loadDocuments();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search and Filter Section
            SliverToBoxAdapter(
              child: _buildSearchAndFilterSection(context),
            ),
            
            // Document List
            documents.when(
              data: (docs) => _buildDocumentList(context, _filterAndSortDocuments(docs)),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                      const SizedBox(height: 16),
                      Text('Error loading documents', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(error.toString(), style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(searchResultsProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'My Documents',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => _showSortBottomSheet(context),
        ),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => _showFilterBottomSheet(context),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilterSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search documents...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            onChanged: (value) => ref
                .read(searchQueryProvider.notifier)
                .update((state) => value),
          ),
          const SizedBox(height: 12),
          
          // Filter Chips
          _buildFilterChips(context),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', DocumentFilter.all, Icons.folder_outlined),
          _buildFilterChip('Favorites', DocumentFilter.favorites, Icons.star_outline),
          _buildFilterChip('Expiring Soon', DocumentFilter.expiring, Icons.warning_amber_outlined),
          _buildFilterChip('Cards', DocumentFilter.cards, Icons.credit_card),
          _buildFilterChip('Documents', DocumentFilter.documents, Icons.description),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, DocumentFilter filter, IconData icon) {
    final isSelected = _selectedFilter == filter;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = filter;
          });
        },
        backgroundColor: Colors.grey.shade100,
        selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        checkmarkColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildDocumentList(BuildContext context, List docs) {
    if (docs.isEmpty) {
      return SliverFillRemaining(
        child: _buildEmptyState(context),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final doc = docs[index];
            return DocumentCard(
              document: doc,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DocumentViewerPage(
                      document: doc,
                    ),
                  ),
                );
              },
              onEdit: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddEditDocumentPage(
                      documentId: doc.id,
                    ),
                  ),
                );
              },
              onDelete: () => _handleDeleteDocument(context, doc),
              onEnableSmartFeatures: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditDocumentSmartFeaturesPage(
                      documentId: doc.id,
                    ),
                  ),
                );
              },
            );
          },
          childCount: docs.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isNotEmpty ? Icons.search_off : Icons.folder_open_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isNotEmpty 
                ? 'No documents found'
                : 'No documents yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searchQuery.isNotEmpty
                ? 'Try adjusting your search or filters'
                : 'Add your first document to get started',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            if (searchQuery.isEmpty) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _showDocumentSourceBottomSheet(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Document'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Scroll to Top FAB
        if (_showScrollToTop)
          FloatingActionButton.small(
            heroTag: "scrollToTop",
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        
        if (_showScrollToTop) const SizedBox(height: 8),
        
        // Add Document FAB
        ScaleTransition(
          scale: _fabAnimation,
          child: FloatingActionButton(
            heroTag: "addDocument",
            onPressed: () => _showDocumentSourceBottomSheet(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  List _filterAndSortDocuments(List docs) {
    // Apply filters
    var filtered = docs.where((doc) {
      switch (_selectedFilter) {
        case DocumentFilter.all:
          return true;
        case DocumentFilter.favorites:
          return doc.isFavorite;
        case DocumentFilter.expiring:
          return doc.expiryDate != null && 
                 doc.expiryDate!.difference(DateTime.now()).inDays <= 60;
        case DocumentFilter.cards:
          // Cards: KTP, SIM, Passport (ID-like documents)
          return doc.type == DocumentType.ktp || 
                 doc.type == DocumentType.sim || 
                 doc.type == DocumentType.passport;
        case DocumentFilter.documents:
          // Documents: Certificates, Diplomas, Others (non-ID documents)
          return doc.type == DocumentType.sertifikat || 
                 doc.type == DocumentType.ijazah || 
                 doc.type == DocumentType.lainnya;
      }
    }).toList();

    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;
      switch (_selectedSort) {
        case SortOption.dateUpdated:
          comparison = a.updatedAt.compareTo(b.updatedAt);
          break;
        case SortOption.dateCreated:
          comparison = a.createdAt.compareTo(b.createdAt);
          break;
        case SortOption.title:
          comparison = a.title.toLowerCase().compareTo(b.title.toLowerCase());
          break;
        case SortOption.type:
          comparison = a.type.index.compareTo(b.type.index);
          break;
      }
      return _isAscending ? comparison : -comparison;
    });

    return filtered;
  }

  Future<void> _handleDeleteDocument(BuildContext context, dynamic doc) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: const Text(
          'Are you sure you want to delete this document? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await ref.read(documentsNotifierProvider.notifier).deleteDocument(doc.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...SortOption.values.map((option) => RadioListTile<SortOption>(
              title: Text(_getSortOptionLabel(option)),
              value: option,
              groupValue: _selectedSort,
              onChanged: (value) {
                setState(() {
                  _selectedSort = value!;
                });
                Navigator.pop(context);
              },
            )),
            const Divider(),
            SwitchListTile(
              title: const Text('Ascending'),
              subtitle: Text(_isAscending ? 'A to Z, Old to New' : 'Z to A, New to Old'),
              value: _isAscending,
              onChanged: (value) {
                setState(() {
                  _isAscending = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DocumentFilter.values.map((filter) => ChoiceChip(
                label: Text(_getFilterLabel(filter)),
                selected: _selectedFilter == filter,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                    Navigator.pop(context);
                  }
                },
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _getSortOptionLabel(SortOption option) {
    switch (option) {
      case SortOption.dateUpdated:
        return 'Date Updated';
      case SortOption.dateCreated:
        return 'Date Created';
      case SortOption.title:
        return 'Title';
      case SortOption.type:
        return 'Document Type';
    }
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
        return 'Cards (KTP, SIM, Passport)';
      case DocumentFilter.documents:
        return 'Documents (Certificate, Diploma, Others)';
    }
  }

  void _showDocumentSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DocumentSourceBottomSheet(
        onDocumentSelected: (File file) {
          // Navigate to quick save page (Phase 3)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuickSaveDocumentPage(
                documentFile: file,
              ),
            ),
          );
        },
      ),
    );
  }
}
