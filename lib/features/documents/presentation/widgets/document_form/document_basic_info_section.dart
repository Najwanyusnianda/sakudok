import 'package:flutter/material.dart';

class DocumentBasicInfoSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<List<String>> onTagsChanged;

  const DocumentBasicInfoSection({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.tagsController,
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.onTagsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade700),
            const SizedBox(width: 8),
            Text(
              'Document Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Basic information about your document',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        // Title Field
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Title *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.title),
            hintText: 'Give your document a clear title',
          ),
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Title is required';
            }
            if (value.length < 3) {
              return 'Title must be at least 3 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Description Field
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description (Optional)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.description),
            hintText: 'Add any additional notes or details',
          ),
          textCapitalization: TextCapitalization.sentences,
          maxLines: 3,
          maxLength: 500,
        ),
        const SizedBox(height: 16),

        // Tags Field
        TextFormField(
          controller: tagsController,
          decoration: const InputDecoration(
            labelText: 'Tags (Optional)',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.tag),
            hintText: 'personal, important, work, family',
            helperText: 'Separate tags with commas for better organization',
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            final tags = value
                .split(',')
                .map((tag) => tag.trim())
                .where((tag) => tag.isNotEmpty)
                .toList();
            onTagsChanged(tags);
          },
        ),
        const SizedBox(height: 16),

        // Favorite Toggle
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SwitchListTile(
            title: const Text('Mark as Favorite'),
            subtitle: const Text('Quick access in favorites section'),
            secondary: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : Colors.grey,
            ),
            value: isFavorite,
            onChanged: onFavoriteChanged,
          ),
        ),
        const SizedBox(height: 8),

        // Quick Tips
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tip: Use descriptive titles and relevant tags to make documents easier to find later',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
