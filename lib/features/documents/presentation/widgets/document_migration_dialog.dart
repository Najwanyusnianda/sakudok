import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/document_migration_service.dart';

class DocumentMigrationDialog extends ConsumerStatefulWidget {
  const DocumentMigrationDialog({super.key});

  @override
  ConsumerState<DocumentMigrationDialog> createState() => _DocumentMigrationDialogState();
}

class _DocumentMigrationDialogState extends ConsumerState<DocumentMigrationDialog> {
  bool _isMigrating = false;
  DocumentMigrationResult? _result;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Secure Your Documents'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isMigrating && _result == null) ...[
              const Text(
                'SakuDok can now store your documents more securely in the app\'s private storage. This prevents "File not found" errors if you move or delete original files.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Benefits:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildBenefitItem('✓ No more "File not found" errors'),
              _buildBenefitItem('✓ Better organization and security'),
              _buildBenefitItem('✓ Automatic cleanup when app is uninstalled'),
              const SizedBox(height: 16),
              const Text(
                'Would you like to migrate your existing documents?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ] else if (_isMigrating) ...[
              const Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Migrating documents to secure storage...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ] else if (_result != null) ...[
              _buildResultView(),
            ],
          ],
        ),
      ),
      actions: [
        if (!_isMigrating && _result == null) ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Skip'),
          ),
          ElevatedButton(
            onPressed: _startMigration,
            child: const Text('Migrate Now'),
          ),
        ] else if (_result != null) ...[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Done'),
          ),
        ],
      ],
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.green.shade700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildResultView() {
    final result = _result!;
    final isSuccess = result.allMigrated;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.warning,
              color: isSuccess ? Colors.green : Colors.orange,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isSuccess ? 'Migration Complete!' : 'Migration Finished with Issues',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildResultItem('Total Documents', '${result.totalDocuments}'),
        _buildResultItem('Successfully Migrated', '${result.migratedCount}', 
            color: Colors.green),
        if (result.failedCount > 0)
          _buildResultItem('Failed to Migrate', '${result.failedCount}', 
              color: Colors.red),
        if (result.hasErrors) ...[
          const SizedBox(height: 8),
          const Text(
            'Issues:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...result.errors.take(3).map((error) => Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              '• $error',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red.shade600,
              ),
            ),
          )),
          if (result.errors.length > 3)
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Text(
                '• ... and ${result.errors.length - 3} more',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red.shade600,
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildResultItem(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startMigration() async {
    setState(() {
      _isMigrating = true;
    });

    try {
      final migrationService = ref.read(documentMigrationServiceProvider);
      final result = await migrationService.migrateAllDocuments();
      
      setState(() {
        _result = result;
        _isMigrating = false;
      });
    } catch (e) {
      setState(() {
        _result = DocumentMigrationResult(
          totalDocuments: 0,
          migratedCount: 0,
          failedCount: 1,
          errors: ['Migration failed: $e'],
        );
        _isMigrating = false;
      });
    }
  }
}

/// Show the migration dialog
Future<bool?> showDocumentMigrationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const DocumentMigrationDialog(),
  );
}
