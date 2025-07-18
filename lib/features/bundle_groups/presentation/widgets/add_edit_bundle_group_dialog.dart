import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_group_providers.dart';
import '../../domain/entities/bundle_group.dart';

class AddEditBundleGroupDialog extends ConsumerStatefulWidget {
  final BundleGroup? bundleGroup;

  const AddEditBundleGroupDialog({
    super.key,
    this.bundleGroup,
  });

  @override
  ConsumerState<AddEditBundleGroupDialog> createState() => _AddEditBundleGroupDialogState();
}

class _AddEditBundleGroupDialogState extends ConsumerState<AddEditBundleGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _displayOrderController = TextEditingController();
  
  String? _selectedIconName;
  String? _selectedColorHex;
  bool _isLoading = false;

  bool get isEditing => widget.bundleGroup != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final group = widget.bundleGroup!;
      _nameController.text = group.name;
      _displayOrderController.text = group.displayOrder.toString();
      _selectedIconName = group.iconName;
      _selectedColorHex = group.colorHex;
    } else {
      _selectedIconName = BundleGroup.availableIcons.first;
      _selectedColorHex = BundleGroup.availableColors.first;
      _displayOrderController.text = '0';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _displayOrderController.dispose();
    super.dispose();
  }
        @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Edit Bundle Group' : 'Add Bundle Group'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  hintText: 'e.g., Work, Education, Travel',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a group name';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Icon Selection
              _buildIconSelection(),
              
              const SizedBox(height: 16),
              
              // Color Selection
              _buildColorSelection(),
              
              const SizedBox(height: 16),
              
              // Display Order Field
              TextFormField(
                controller: _displayOrderController,
                decoration: const InputDecoration(
                  labelText: 'Display Order',
                  hintText: '0',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter display order';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveBundleGroup,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }

  Widget _buildIconSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Icon',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: BundleGroup.availableIcons.map((iconName) {
            final isSelected = _selectedIconName == iconName;
            final icon = _getIconData(iconName);
            final color = isSelected 
                ? Theme.of(context).colorScheme.primary 
                : Colors.grey.shade400;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIconName = iconName;
                });
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: BundleGroup.availableColors.map((colorHex) {
            final isSelected = _selectedColorHex == colorHex;
            final color = Color(int.parse(colorHex.substring(1, 7), radix: 16) + 0xFF000000);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorHex = colorHex;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey.shade300,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected 
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
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

  Future<void> _saveBundleGroup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final bundleGroup = BundleGroup(
        id: isEditing ? widget.bundleGroup!.id : 0, // ID will be set by database
        name: _nameController.text.trim(),
        iconName: _selectedIconName,
        colorHex: _selectedColorHex,
        displayOrder: int.parse(_displayOrderController.text),
        createdAt: isEditing ? widget.bundleGroup!.createdAt : DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final success = isEditing
          ? await ref.read(bundleGroupsNotifierProvider.notifier).updateBundleGroup(bundleGroup)
          : await ref.read(bundleGroupsNotifierProvider.notifier).addBundleGroup(bundleGroup);

      if (mounted) {
        if (success) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing 
                    ? 'Bundle group updated successfully'
                    : 'Bundle group added successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing 
                    ? 'Failed to update bundle group'
                    : 'Failed to add bundle group',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.bundleGroup == null ? 'Add Bundle Group' : 'Edit Bundle Group'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  hintText: 'e.g. Work, Education, Medical',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a group name';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Icon Selection
              const Text(
                'Icon',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: BundleGroup.availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconName = BundleGroup.availableIcons[index];
                    final isSelected = _selectedIcon == iconName;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = iconName;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Icon(
                          _getIconData(iconName),
                          color: isSelected ? Colors.blue : Colors.grey.shade600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Color Selection
              const Text(
                'Color',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: BundleGroup.availableColors.length,
                  itemBuilder: (context, index) {
                    final colorHex = BundleGroup.availableColors[index];
                    final color = Color(int.parse(colorHex.substring(1, 7), radix: 16) + 0xFF000000);
                    final isSelected = _selectedColor == colorHex;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = colorHex;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.bundleGroup == null ? 'Create' : 'Update'),
        ),
      ],
    );
  }

  IconData _getIconData(String iconName) {
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

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final bundleGroup = widget.bundleGroup?.copyWith(
        name: _nameController.text.trim(),
        iconName: _selectedIcon,
        colorHex: _selectedColor,
      ) ?? BundleGroup(
        id: 0, // Will be assigned by database
        name: _nameController.text.trim(),
        iconName: _selectedIcon,
        colorHex: _selectedColor,
        displayOrder: 0, // Will be handled by the repository
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await widget.onSave(bundleGroup);
      
      if (mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
