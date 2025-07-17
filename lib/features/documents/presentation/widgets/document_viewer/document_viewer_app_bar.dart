import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/entities/document.dart';
import '../../pages/add_edit_document_page.dart';

class DocumentViewerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Document document;
  final int currentIndex;
  final VoidCallback onInfoTap;
  final VoidCallback onShareTap;

  const DocumentViewerAppBar({
    super.key,
    required this.document,
    required this.currentIndex,
    required this.onInfoTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.7),
      foregroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            document.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (document.images.length > 1)
            Text(
              '${currentIndex + 1} of ${document.images.length}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddEditDocumentPage(
                  documentId: document.id,
                ),
              ),
            );
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'share') {
              onShareTap();
            } else if (value == 'info') {
              onInfoTap();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share_outlined, size: 20),
                  SizedBox(width: 12),
                  Text('Share'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20),
                  SizedBox(width: 12),
                  Text('Document Info'),
                ],
              ),
            ),
          ],
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
