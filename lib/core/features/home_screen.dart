// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'dart:ui';

import 'package:jolly_podcast/core/components/utils/global_index_tab.dart';
import 'package:jolly_podcast/core/features/discover/controller/discover_home_screen.dart';

import '../components/utils/colors.dart';
import '../components/utils/package_export.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key, required this.index});
  final int index;
  @override
  _NavBarfeaturestate createState() => _NavBarfeaturestate();
}

class _NavBarfeaturestate extends State<HomeScreenPage>
    with WidgetsBindingObserver {
  int _currentIndex = 0;

  // Navigator keys for each tab
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentIndex = widget.index;
    });
    WidgetsBinding.instance.addObserver(this); // Add observer
    setStatus(true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  void setStatus(bool status) async {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("Lifecycle state: $state");
    switch (state) {
      case AppLifecycleState.resumed:
        setStatus(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        setStatus(false);
        break;
    }
  }

  int tabselected = 0;

  Future<bool> _onPopInvoked(bool isPop, pop) async {
    // If the current tab can pop a page → pop it
    if (await _navigatorKeys[_currentIndex].currentState!.maybePop()) {
      return false;
    }

    // If not on first tab, go back to home tab
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }

    // Otherwise show exit dialog
    return (await showDialog(
          context: context,
          barrierDismissible: true,
          useRootNavigator: false,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              title: const Text(
                'Exit App',
                style: TextStyle(color: AppColors.primary),
              ),
              content: const Text(
                'Do you want to exit the app?',
                style: TextStyle(color: AppColors.primary),
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: _onPopInvoked,
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            TabNavigator(
              navigatorKey: _navigatorKeys[0],
              child: DiscoverHomeScreen(),
            ),
            TabNavigator(navigatorKey: _navigatorKeys[1], child: Container()),
            TabNavigator(navigatorKey: _navigatorKeys[2], child: Container()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.greenBackground,
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
          selectedItemColor: AppColors.bodyWhite,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => onTabTapped(index),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/discover_icon.png",
                  width: 20,
                  color: _currentIndex == 0 ? AppColors.bodyWhite : Colors.grey,
                ),
              ),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/category_icon.png",
                  width: 20,
                  color: _currentIndex == 1 ? AppColors.bodyWhite : Colors.grey,
                ),
              ),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/library_icon.png",
                  width: 20,
                  color: _currentIndex == 2 ? AppColors.bodyWhite : Colors.grey,
                ),
              ),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    if (index == _currentIndex) {
      // Reselecting → pop to root inside that tab
      _navigatorKeys[index].currentState!.popUntil((r) => r.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
