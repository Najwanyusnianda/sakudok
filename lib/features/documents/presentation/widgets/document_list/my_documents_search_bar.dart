// lib/features/documents/presentation/widgets/document_list/my_documents_search_bar.dart
import 'package:flutter/material.dart';

class MyDocumentsSearchBar extends StatefulWidget {
  final bool isVisible;
  final String searchQuery;
  final ValueChanged<String> onSearchQueryChanged;
  final VoidCallback onClearSearch;
  final VoidCallback onSearchDismissed;

  const MyDocumentsSearchBar({
    super.key,
    required this.isVisible,
    required this.searchQuery,
    required this.onSearchQueryChanged,
    required this.onClearSearch,
    required this.onSearchDismissed,
  });

  @override
  State<MyDocumentsSearchBar> createState() => _MyDocumentsSearchBarState();
}

class _MyDocumentsSearchBarState extends State<MyDocumentsSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _slideAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _textController.text = widget.searchQuery;
  }

  @override
  void didUpdateWidget(MyDocumentsSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle visibility changes
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _animationController.forward();
        // Auto-focus when search becomes active
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNode.requestFocus();
        });
      } else {
        _animationController.reverse();
        _focusNode.unfocus();
      }
    }
    
    // Update text if search query changed externally
    if (widget.searchQuery != _textController.text) {
      _textController.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(_slideAnimation),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: TextField(
            controller: _textController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Search documents...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade600,
                size: 20,
              ),
              suffixIcon: widget.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      onPressed: () {
                        _textController.clear();
                        widget.onClearSearch();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              height: 1.2,
            ),
            onChanged: widget.onSearchQueryChanged,
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
    );
  }
}
