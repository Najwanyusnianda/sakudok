// lib/features/bundles/presentation/widgets/bundle_list/bundle_list_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakudok/features/bundles/domain/entities/bundle.dart';
import 'package:sakudok/features/bundles/presentation/pages/bundle_detail_page.dart';
import '../../providers/bundle_providers.dart';
import '../bundle_card.dart';
import '../suggested_bundle_card.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../pages/add_edit_bundle_page.dart';

class BundleListContent extends ConsumerWidget {
  final int selectedTabIndex;

  const BundleListContent({
    super.key,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundlesAsync = ref.watch(bundlesNotifierProvider);
    final suggestedBundlesAsync = ref.watch(suggestedBundlesProvider);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Show suggested bundles only for the "All" tab
        if (selectedTabIndex == 0)
          suggestedBundlesAsync.when(
            data: (suggested) {
              if (suggested.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Suggested For You', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: suggested.length,
                      itemBuilder: (context, index) => SuggestedBundleCard(bundle: suggested[index]),
                    ),
                  ),
                  const Divider(height: 32),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err'),
          ),
        
        // Main Bundle List
        bundlesAsync.when(
          data: (bundles) {
            if (bundles.isEmpty) {
              return EmptyStateWidget(
                message: 'No bundles yet. Create one!',
                icon: Icons.collections_bookmark_outlined,
                actionText: 'Create Bundle',
                onAction: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddEditBundlePage(),
                )),
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
                  // --- FIX: Added the required onTap and other actions ---
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BundleDetailPage(bundleId: bundle.id),
                    ));
                  },
                  onEdit: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddEditBundlePage(bundleId: bundle.id),
                    ));
                  },
                  onDelete: () {
                    // You'll need to implement the delete dialog logic here
                    // For example: _showDeleteBundleDialog(context, ref, bundle);
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ],
    );
  }
}
