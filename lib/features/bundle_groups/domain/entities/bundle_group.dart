import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'bundle_group.freezed.dart';
part 'bundle_group.g.dart';

@freezed
abstract class BundleGroup with _$BundleGroup {
  const factory BundleGroup({
    required int id,
    required String name,
    String? iconName,
    String? colorHex,
    @Default(0) int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BundleGroup;

  factory BundleGroup.fromJson(Map<String, dynamic> json) =>
      _$BundleGroupFromJson(json);

  // Convenience getters
  const BundleGroup._();

  IconData get icon {
    if (iconName == null) return Icons.folder;
    
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'school':
        return Icons.school;
      case 'home':
        return Icons.home;
      case 'medical':
        return Icons.medical_services;
      case 'travel':
        return Icons.flight;
      case 'finance':
        return Icons.account_balance;
      case 'legal':
        return Icons.gavel;
      case 'insurance':
        return Icons.security;
      default:
        return Icons.folder;
    }
  }

  Color get color {
    if (colorHex == null) return Colors.blue;
    
    try {
      return Color(int.parse(colorHex!.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      return Colors.blue;
    }
  }

  static List<String> get availableIcons => [
        'work',
        'school', 
        'home',
        'medical',
        'travel',
        'finance',
        'legal',
        'insurance',
      ];

  static List<String> get availableColors => [
        '#2196F3', // Blue
        '#4CAF50', // Green
        '#FF9800', // Orange
        '#9C27B0', // Purple
        '#F44336', // Red
        '#607D8B', // Blue Grey
        '#795548', // Brown
        '#009688', // Teal
      ];
}
