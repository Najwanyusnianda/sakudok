import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../providers/document_providers.dart';
import '../widgets/document_card.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import 'add_edit_document_page.dart';
import 'quick_save_document_page.dart';
import 'edit_document_smart_features_page.dart';
import '../widgets/document_capture/document_source_bottom_sheet.dart';

class DocumentListPage extends ConsumerStatefulWidget {
  const DocumentListPage({super.key});

  @override
  ConsumerState<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends ConsumerState<DocumentListPage> {
  @override
  Widget build(BuildContext context) {
    final documents = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showDocumentSourceBottomSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari dokumen...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => ref
                  .read(searchQueryProvider.notifier)
                  .update((state) => value),
            ),
          ),
          Expanded(
            child: documents.when(
              data: (docs) {
                if (docs.isEmpty) {
                  return const EmptyStateWidget(
                    message: 'Belum ada dokumen',
                    icon: Icons.folder_open,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DocumentCard(
                        document: doc,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddEditDocumentPage(
                                documentId: doc.id,
                              ),
                            ),
                          );
                        },
                        onDelete: () async {
                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Hapus Dokumen'),
                              content: const Text(
                                'Apakah Anda yakin ingin menghapus dokumen ini?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                  child: const Text('Hapus'),
                                ),
                              ],
                            ),
                          );

                          if (shouldDelete == true) {
                            await ref
                                .read(documentsNotifierProvider.notifier)
                                .deleteDocument(doc.id);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dokumen berhasil dihapus'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
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
