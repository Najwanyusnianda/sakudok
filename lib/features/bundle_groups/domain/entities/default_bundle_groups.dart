import '../entities/bundle_group.dart';

class DefaultBundleGroups {
  static List<BundleGroup> get defaultGroups => [
    BundleGroup(
      id: 0,
      name: 'Work',
      iconName: 'work',
      colorHex: '#2196F3',
      displayOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BundleGroup(
      id: 0,
      name: 'Education',
      iconName: 'school',
      colorHex: '#4CAF50',
      displayOrder: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BundleGroup(
      id: 0,
      name: 'Medical',
      iconName: 'medical',
      colorHex: '#F44336',
      displayOrder: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BundleGroup(
      id: 0,
      name: 'Travel',
      iconName: 'travel',
      colorHex: '#9C27B0',
      displayOrder: 3,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    BundleGroup(
      id: 0,
      name: 'Finance',
      iconName: 'finance',
      colorHex: '#FF9800',
      displayOrder: 4,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}
