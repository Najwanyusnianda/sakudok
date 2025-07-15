import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/document_providers.dart';
import '../widgets/document_card.dart';
import '../../../../core/widgets/empty_state_widget.dart';

class DocumentListPage extends ConsumerWidget {
  const DocumentListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final documents = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.pushNamed('add-document'),
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
                        onTap: () => context.pushNamed(
                          'edit-document',
                          pathParameters: {'id': doc.id},
                        ),
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
}
