import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../providers/document_providers.dart';
import '../widgets/document_list/document_list_widget.dart';
import '../widgets/document_list/document_sliver_app_bar.dart';
import '../widgets/document_list/filter_drawer.dart';
import '../widgets/document_capture/document_source_bottom_sheet.dart';
import '../../domain/entities/document.dart'; // Assuming you have this entity
import '../../domain/entities/document_type.dart';
import 'quick_save_document_page.dart';

// Enums for filtering and sorting documents
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
  bool _isSearchMode = false;

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
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 400 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentsAsync = ref.watch(documentsNotifierProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: FilterDrawer(
        selectedFilter: _selectedFilter,
        onFilterChanged: (filter) {
          setState(() => _selectedFilter = filter);
        },
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(documentsNotifierProvider.notifier).loadDocuments(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            DocumentSliverAppBar(
              selectedFilter: _selectedFilter,
              onFilterChanged: (filter) =>
                  setState(() => _selectedFilter = filter),
              onSortTap: () => _showSortBottomSheet(context),
              isSearchMode: _isSearchMode,
              onSearchToggle: () => setState(() => _isSearchMode = !_isSearchMode),
            ),
            documentsAsync.when(
              data: (docs) {
                final filteredDocs = _filterAndSortDocuments(docs, searchQuery);
                return DocumentListWidget(
                  documents: filteredDocs,
                  onDelete: (id) => _handleDeleteDocument(context, id),
                  onAdd: () => _showDocumentSourceBottomSheet(context),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  Widget _buildFloatingActionButtons(BuildContext context) {
    // This can also be moved to its own widget file if desired
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_showScrollToTop)
          FloatingActionButton.small(
            heroTag: "scrollToTop",
            onPressed: () => _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut),
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        if (_showScrollToTop) const SizedBox(height: 8),
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

  List<Document> _filterAndSortDocuments(
      List<Document> docs, String searchQuery) {
    List<Document> filteredList;

    // Search
    if (searchQuery.isNotEmpty) {
      filteredList = docs
          .where((doc) =>
              doc.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              doc.type.toString().toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    } else {
      filteredList = List.from(docs);
    }

    // Filter
    filteredList = filteredList.where((doc) {
      switch (_selectedFilter) {
        case DocumentFilter.all:
          return true;
        case DocumentFilter.favorites:
          return doc.isFavorite;
        case DocumentFilter.expiring:
          return doc.expiryDate != null &&
              doc.expiryDate!.difference(DateTime.now()).inDays <= 60;
        case DocumentFilter.cards:
          return [DocumentType.ktp, DocumentType.sim, DocumentType.passport]
              .contains(doc.type);
        case DocumentFilter.documents:
          return ![DocumentType.ktp, DocumentType.sim, DocumentType.passport]
              .contains(doc.type);
      }
    }).toList();

    // Sort
    filteredList.sort((a, b) {
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

    return filteredList;
  }

  Future<void> _handleDeleteDocument(BuildContext context, String docId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: const Text(
            'Are you sure you want to delete this document? This action cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await ref.read(documentsNotifierProvider.notifier).deleteDocument(docId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Document deleted successfully'),
          backgroundColor: Colors.green,
        ));
      }
    }
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter modalState) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sort by',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                ...SortOption.values.map((option) => RadioListTile<SortOption>(
                      title: Text(_getSortOptionLabel(option)),
                      value: option,
                      groupValue: _selectedSort,
                      onChanged: (value) {
                        setState(() => _selectedSort = value!);
                        modalState(() {});
                        Navigator.pop(context);
                      },
                    )),
                const Divider(),
                SwitchListTile(
                  title: const Text('Ascending'),
                  subtitle: Text(_isAscending
                      ? 'A to Z, Old to New'
                      : 'Z to A, New to Old'),
                  value: _isAscending,
                  onChanged: (value) {
                    setState(() => _isAscending = value);
                    modalState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDocumentSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DocumentSourceBottomSheet(
        onDocumentSelected: (File file) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuickSaveDocumentPage(documentFile: file),
          ));
        },
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
}
