import 'package:flutter/material.dart';
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
    if (widget.document.images.length > 1) {
      _pageController = PageController();
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _toggleUI() {
    setState(() {
      _showUI = !_showUI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _showUI
          ? DocumentViewerAppBar(
              document: widget.document,
              currentIndex: _currentIndex,
              onInfoTap: _showDocumentInfo,
              onShareTap: _shareDocument,
            )
          : null,
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
      bottomNavigationBar: _showUI && widget.document.images.length > 1
          ? _buildBottomNavigationBar()
          : null,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _currentIndex > 0 ? _previousPage : null,
              icon: Icon(
                Icons.chevron_left,
                color: _currentIndex > 0 ? Colors.white : Colors.grey.shade600,
                size: 32,
              ),
            ),
            Text(
              '${_currentIndex + 1} / ${widget.document.images.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: _currentIndex < widget.document.images.length - 1
                  ? _nextPage
                  : null,
              icon: Icon(
                Icons.chevron_right,
                color: _currentIndex < widget.document.images.length - 1
                    ? Colors.white
                    : Colors.grey.shade600,
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
        backgroundColor: Colors.blue,
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
