import 'package:equatable/equatable.dart';
import 'bundle_template_requirement.dart';

class BundleUserTemplate extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<BundleTemplateRequirement> requirements;
  final DateTime createdAt;

  const BundleUserTemplate({
    required this.id,
    required this.name,
    this.description = '',
    required this.requirements,
    required this.createdAt,
  });

  BundleUserTemplate copyWith({
    String? id,
    String? name,
    String? description,
    List<BundleTemplateRequirement>? requirements,
    DateTime? createdAt,
  }) {
    return BundleUserTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, description, requirements, createdAt];
}
