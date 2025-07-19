// lib/features/bundle_groups/presentation/widgets/icon_picker.dart
import 'package:flutter/material.dart';
import '../../domain/entities/bundle_group.dart';

class IconPicker extends StatelessWidget {
  final String selectedIconName;
  final ValueChanged<String> onIconChanged;

  const IconPicker({
    super.key,
    required this.selectedIconName,
    required this.onIconChanged,
  });

  // --- FIX: Moved the icon mapping logic here to make the widget self-contained ---
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'work': return Icons.work_outline;
      case 'school': return Icons.school_outlined;
      case 'home': return Icons.home_outlined;
      case 'medical': return Icons.medical_services_outlined;
      case 'travel': return Icons.flight_takeoff_outlined;
      case 'finance': return Icons.account_balance_wallet_outlined;
      case 'legal': return Icons.gavel_outlined;
      case 'insurance': return Icons.security_outlined;
      default: return Icons.folder_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: BundleGroup.availableIcons.map((iconName) {
        final isSelected = selectedIconName == iconName;
        final theme = Theme.of(context);
        return GestureDetector(
          onTap: () => onIconChanged(iconName),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Icon(
              _getIconData(iconName),
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              size: 28,
            ),
          ),
        );
      }).toList(),
    );
  }
}