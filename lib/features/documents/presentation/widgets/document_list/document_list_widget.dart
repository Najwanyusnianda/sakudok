import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/document.dart'; // Adjust import path
import '../../pages/add_edit_document_page.dart';
import '../../pages/document_viewer_page.dart';
import '../../pages/edit_document_smart_features_page.dart';
import '../document_card.dart';
import '../../providers/document_providers.dart'; // Adjust import path

class DocumentListWidget extends ConsumerWidget {
  final List<Document> documents;
  final Function(String) onDelete;
  final Function() onAdd;

  const DocumentListWidget({
    super.key,
    required this.documents,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    if (documents.isEmpty) {
      return SliverFillRemaining(
        child: _buildEmptyState(context, searchQuery),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // Padding for FAB
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final doc = documents[index];
            return DocumentCard(
              document: doc,
              onTap: () {
                // --- START DEBUGGING ---
                // Print the document details when the card is tapped.
                // This helps verify the path being sent to the viewer.
                debugPrint("DEBUG: Tapped on document: '${doc.title}'");
                debugPrint("DEBUG: File path being passed to viewer: ${doc.filePaths.isNotEmpty ? doc.filePaths.first : 'No file path'}");
                // --- END DEBUGGING ---

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DocumentViewerPage(document: doc),
                ));
              },
              onEdit: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddEditDocumentPage(documentId: doc.id),
              )),
              onDelete: () => onDelete(doc.id),
              onEnableSmartFeatures: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    EditDocumentSmartFeaturesPage(documentId: doc.id),
              )),
            );
          },
          childCount: documents.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String searchQuery) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isNotEmpty
                  ? Icons.search_off
                  : Icons.folder_open_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isNotEmpty ? 'No documents found' : 'No documents yet',
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
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add Document'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
