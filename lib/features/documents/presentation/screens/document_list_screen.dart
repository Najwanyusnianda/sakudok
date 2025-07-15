import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakudok/core/theme/app_colors.dart';
import 'package:sakudok/core/widgets/custom_app_bar.dart';
import 'package:sakudok/features/documents/presentation/providers/document_providers.dart';
import 'package:sakudok/features/documents/domain/entities/document.dart';

class DocumentListScreen extends ConsumerWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(documentsProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Documents',
        actions: [],
      ),
      body: documentsAsync.when(
        data: (documents) {
          if (documents.isEmpty) {
            return const Center(
              child: Text('No documents yet. Tap + to add one.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    document.title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    (document.description?.length ?? 0) > 100
                        ? '${document.description!.substring(0, 100)}...'
                        : document.description ?? 'Tidak ada deskripsi',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    context.push('/documents/${document.id}');
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading documents: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/documents/new');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
