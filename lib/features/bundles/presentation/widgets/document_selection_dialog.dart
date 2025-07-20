// lib/features/bundles/presentation/widgets/document_selection_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../documents/presentation/providers/document_providers.dart';
import '../../../documents/domain/entities/document.dart';

class DocumentSelectionDialog extends ConsumerStatefulWidget {
  final String slotName;
  final String requiredDocType;
  final Function(Document) onDocumentSelected;

  const DocumentSelectionDialog({
    super.key,
    required this.slotName,
    required this.requiredDocType,
    required this.onDocumentSelected,
  });

  @override
  ConsumerState<DocumentSelectionDialog> createState() => _DocumentSelectionDialogState();
}

class _DocumentSelectionDialogState extends ConsumerState<DocumentSelectionDialog> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentsAsync = ref.watch(documentsNotifierProvider);
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.attach_file,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attach Document',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Select document for: ${widget.slotName}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search documents...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Document List
            Expanded(
              child: documentsAsync.when(
                data: (documents) {
                  final filteredDocs = _filterDocuments(documents);
                  
                  if (filteredDocs.isEmpty) {
                    return _buildEmptyState();
                  }
                  
                  return ListView.separated(
                    itemCount: filteredDocs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final doc = filteredDocs[index];
                      return _buildDocumentTile(doc);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load documents',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Actions
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _createNewDocument(),
                    icon: const Icon(Icons.add),
                    label: const Text('Create New Document'),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Document> _filterDocuments(List<Document> documents) {
    var filtered = documents;
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((doc) =>
          doc.title.toLowerCase().contains(_searchQuery) ||
          doc.mainType.toString().toLowerCase().contains(_searchQuery)).toList();
    }
    
    // Sort by relevance - documents matching the required type first
    filtered.sort((a, b) {
      final aMatches = a.mainType.toString().toLowerCase().contains(widget.requiredDocType.toLowerCase());
      final bMatches = b.mainType.toString().toLowerCase().contains(widget.requiredDocType.toLowerCase());
      
      if (aMatches && !bMatches) return -1;
      if (!aMatches && bMatches) return 1;
      
      // Secondary sort by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });
    
    return filtered;
  }

  Widget _buildDocumentTile(Document document) {
    final isRecommended = document.mainType.toString().toLowerCase()
        .contains(widget.requiredDocType.toLowerCase());
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isRecommended 
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isRecommended 
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.grey.shade100,
          child: Icon(
            document.mainType.icon,
            color: isRecommended 
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade600,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                document.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isRecommended)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(document.mainType.displayName),
            Text(
              'Created: ${_formatDate(document.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).pop();
          widget.onDocumentSelected(document);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No documents found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty 
                ? 'Try adjusting your search terms'
                : 'Create your first document to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _createNewDocument() {
    // TODO: Navigate to document creation page
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create document functionality coming soon!')),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
