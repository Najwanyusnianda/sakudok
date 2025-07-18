// lib/features/bundles/presentation/pages/bundle_main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../bundle_groups/domain/entities/bundle_group.dart';
import '../providers/bundle_providers.dart';
import '../../../bundle_groups/presentation/providers/bundle_group_providers.dart';
import '../widgets/bundle_list/bundle_app_bar.dart';
import '../widgets/bundle_list/bundle_list_content.dart';

class BundleMainPage extends ConsumerStatefulWidget {
  const BundleMainPage({super.key});

  @override
  ConsumerState<BundleMainPage> createState() => _BundleMainPageState();
}

class _BundleMainPageState extends ConsumerState<BundleMainPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize with a default length; it will be rebuilt when data loads.
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _setupTabController(List<BundleGroup> groups) {
    // Recreate the TabController only if the number of tabs has changed.
    if (_tabController.length != groups.length + 1) {
      _tabController.dispose();
      _tabController = TabController(length: groups.length + 1, vsync: this);
      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          final selectedGroupId = _tabController.index == 0
              ? null
              : groups[_tabController.index - 1].id;
          ref.read(selectedBundleGroupProvider.notifier).state = selectedGroupId;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bundleGroupsAsync = ref.watch(bundleGroupsNotifierProvider);

    return bundleGroupsAsync.when(
      data: (groups) {
        // Ensure the TabController is correctly set up for the number of groups.
        _setupTabController(groups);

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              // Invalidate all relevant providers to trigger a full refresh.
              ref.invalidate(bundlesNotifierProvider);
              ref.invalidate(suggestedBundlesProvider);
              ref.invalidate(bundleGroupsNotifierProvider);
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  BundleAppBar(
                    tabController: _tabController,
                    groups: groups,
                  ),
                ];
              },
              body: BundleListContent(
                selectedTabIndex: _tabController.index,
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Bundles')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text('Bundles')),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
