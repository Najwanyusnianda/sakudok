// lib/features/bundles/presentation/widgets/bundle_list/bundle_app_bar.dart
import 'package:flutter/material.dart';
import '../../../../bundle_groups/domain/entities/bundle_group.dart';
import '../../pages/add_edit_bundle_page.dart';
import '../../../../bundle_groups/presentation/pages/manage_bundle_groups_page.dart';

class BundleAppBar extends StatelessWidget {
  final TabController tabController;
  final List<BundleGroup> groups;

  const BundleAppBar({
    super.key,
    required this.tabController,
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Bundles'),
      pinned: true,
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.category_outlined),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ManageBundleGroupsPage(),
          )),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddEditBundlePage(),
          )),
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        tabs: [
          const Tab(text: 'All'),
          ...groups.map((group) => Tab(text: group.name)),
        ],
      ),
    );
  }
}
