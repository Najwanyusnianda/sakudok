//lib/features/documents/presentation/widgets/document_viewer/document_viewer_app_bar.dart
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // Determine the color for text and icons based on the viewer's background
    final onSurfaceColor = theme.brightness == Brightness.dark ? colorScheme.onSurface : Colors.white;
    // Determine the background color for the gradient
    final viewerBackgroundColor = theme.brightness == Brightness.dark ? colorScheme.surface : Colors.black;

    return AppBar(
      // Make the AppBar itself transparent to allow the gradient to show through.
      backgroundColor: Colors.transparent,
      foregroundColor: onSurfaceColor,
      elevation: 0,
      title: Text(
        document.title,
        style: theme.textTheme.titleLarge?.copyWith(
            color: onSurfaceColor,
            fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      // --- FIX: Use flexibleSpace to apply a gradient background ---
      // This creates a visual separation for the title without a hard edge.
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              viewerBackgroundColor,
              viewerBackgroundColor.withOpacity(0.0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.5, 1.0], // Gradient starts fading halfway down the app bar
          ),
        ),
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
      // Make the status bar icons (time, battery) light to contrast with the dark background
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
