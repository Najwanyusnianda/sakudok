// lib/features/bundle_groups/presentation/widgets/color_picker.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_group.dart';

class ColorPicker extends StatelessWidget {
  final String selectedColorHex;
  final ValueChanged<String> onColorChanged;

  const ColorPicker({
    super.key,
    required this.selectedColorHex,
    required this.onColorChanged,
  });

  // --- FIX: Added a helper method to parse the hex string ---
  Color _colorFromHex(String hex) {
    return Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: BundleGroup.availableColors.map((colorHex) {
        final isSelected = selectedColorHex == colorHex;
        final color = _colorFromHex(colorHex);
        final theme = Theme.of(context);
        return GestureDetector(
          onTap: () => onColorChanged(colorHex),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                width: isSelected ? 3 : 1,
              ),
            ),
            child: isSelected
                ? Icon(Icons.check, color: theme.colorScheme.onPrimary, size: 24)
                : null,
          ),
        );
      }).toList(),
    );
  }
}