import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bundle_providers.dart';
import '../widgets/bundle_card.dart';
import '../widgets/suggested_bundle_card.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import 'add_edit_bundle_page.dart';

class BundleMainPage extends ConsumerWidget {
  const BundleMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundlesAsync = ref.watch(bundlesNotifierProvider);
    final suggestedBundlesAsync = ref.watch(suggestedBundlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bundles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddEditBundlePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(bundlesNotifierProvider);
          ref.invalidate(suggestedBundlesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Suggested Bundles Section
            suggestedBundlesAsync.when(
              data: (suggested) {
                if (suggested.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Suggested For You',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: suggested.length,
                        itemBuilder: (context, index) {
                          final bundle = suggested[index];
                          return SuggestedBundleCard(bundle: bundle);
                        },
                      ),
                    ),
                    const Divider(height: 32),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Text('Error: $err'),
            ),

            // My Bundles Section
            Text(
              'My Bundles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            bundlesAsync.when(
              data: (bundles) {
                if (bundles.isEmpty) {
                  return const EmptyStateWidget(
                    message: 'No bundles yet. Create one!',
                    icon: Icons.collections_bookmark_outlined,
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bundles.length,
                  itemBuilder: (context, index) {
                    final bundle = bundles[index];
                    return BundleCard(
                      bundle: bundle,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddEditBundlePage(bundleId: bundle.id),
                          ),
                        );
                      },
                      onEdit: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddEditBundlePage(bundleId: bundle.id),
                          ),
                        );
                      },
                      onDelete: () {
                        // TODO: Implement delete functionality
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Bundle'),
                            content: Text('Are you sure you want to delete "${bundle.name}"?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // TODO: Call delete method
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ],
        ),
      ),
    );
  }
}
