import 'package:flutter/material.dart';
import '../../documents/presentation/pages/document_list_page.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../bundles/presentation/pages/bundle_main_page.dart';
import '../../security/presentation/pages/settings_page.dart';
import 'main_navigation_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    DocumentListPage(),
    BundleMainPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: MainNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
} 