import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemChrome
import '../../domain/entities/document.dart';
import '../widgets/document_viewer/document_info_sheet.dart';
import '../widgets/document_viewer/document_viewer_app_bar.dart';
import '../widgets/document_viewer/document_viewer_body.dart';

class DocumentViewerPage extends StatefulWidget {
  final Document document;

  const DocumentViewerPage({
    super.key,
    required this.document,
  });

  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage> {
  PageController? _pageController;
  int _currentIndex = 0;
  bool _showUI = true;

  @override
  void initState() {
    super.initState();
    if (widget.document.filePaths.length > 1) {
      _pageController = PageController();
    }
  }

  @override
  void dispose() {
    // Restore system UI when leaving the page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _pageController?.dispose();
    super.dispose();
  }

  void _toggleUI() {
    setState(() {
      _showUI = !_showUI;
      if (_showUI) {
        // Show status bar and navigation bar
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      } else {
        // Hide status bar and navigation bar for an immersive view
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the dark theme's surface color for the background for a consistent look
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.surface
        : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      // --- IMPROVEMENT: Use AnimatedSwitcher for smooth transitions ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _showUI
              ? DocumentViewerAppBar(
                  key: const ValueKey('appBar'),
                  document: widget.document,
                  currentIndex: _currentIndex,
                  onInfoTap: _showDocumentInfo,
                  onShareTap: _shareDocument,
                )
              : const SizedBox.shrink(key: ValueKey('hiddenAppBar')),
        ),
      ),
      body: GestureDetector(
        onTap: _toggleUI,
        child: DocumentViewerBody(
          document: widget.document,
          pageController: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      // --- IMPROVEMENT: Use AnimatedSwitcher for the bottom bar as well ---
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _showUI && widget.document.filePaths.length > 1
            ? _buildBottomNavigationBar(context)
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    // --- IMPROVEMENT: Use theme colors instead of hardcoded values ---
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onSurfaceColor = theme.brightness == Brightness.dark ? colorScheme.onSurface : Colors.white;
    final disabledColor = theme.brightness == Brightness.dark ? colorScheme.onSurface.withOpacity(0.3) : Colors.white54;

    return Container(
      // Use a semi-transparent version of the background color
      color: theme.scaffoldBackgroundColor.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _currentIndex > 0 ? _previousPage : null,
              icon: Icon(
                Icons.chevron_left,
                color: _currentIndex > 0 ? onSurfaceColor : disabledColor,
                size: 32,
              ),
            ),
            Text(
              '${_currentIndex + 1} / ${widget.document.filePaths.length}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: onSurfaceColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: _currentIndex < widget.document.filePaths.length - 1
                  ? _nextPage
                  : null,
              icon: Icon(
                Icons.chevron_right,
                color: _currentIndex < widget.document.filePaths.length - 1
                    ? onSurfaceColor
                    : disabledColor,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _previousPage() {
    _pageController?.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    _pageController?.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _shareDocument() {
    // TODO: Implement share functionality using a package like 'share_plus'
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon'),
      ),
    );
  }

  void _showDocumentInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DocumentInfoSheet(document: widget.document),
    );
  }
}
