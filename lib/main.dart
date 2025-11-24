// ignore_for_file: use_build_context_synchronously

import 'package:jolly_podcast/core/components/state/theme_state.dart';
import 'package:jolly_podcast/core/components/state/connectivity_state.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';

import 'core/components/helpers/globals.dart';
import 'core/components/routes/routers.dart';
import 'core/components/utils/package_export.dart';
import 'core/components/routes/routers.dart' as router;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//Store this globally
// Global RouteObserver instance
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  getIt.registerLazySingleton<AppGlobals>(() => AppGlobals());
  await setupLocator();

  await globals.init();
  if (globals.userId.toString().isNotEmpty) {
    await globals.login();
  }
  String? route = await initialRoute();

  runApp(
    ProviderScope(
      child: MyApp(route: route, navigatorKey: navigatorKey),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key, this.route, required this.navigatorKey});
  final String? route;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String? route;

  @override
  void initState() {
    super.initState();

    setState(() {
      route = widget.route;
    });
    // Load theme on app startup
    Future.delayed(Duration.zero, () {
      ref.read(themeNotifierProvider.notifier).loadTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    ref.watch(connectivityStatusProviders);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig.init(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "OctoServe",
                themeMode: themeMode,
                theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
                darkTheme: ThemeData.dark(),
                navigatorObservers: [routeObserver],
                onGenerateRoute: router.generateRoute,
                initialRoute: route,
                navigatorKey: widget.navigatorKey,
                builder: (BuildContext context, Widget? child) {
                  return Stack(
                    children: [
                      /// 👇 Place UpgradeAlert inside MaterialApp
                      UpgradeAlert(
                        showReleaseNotes: false,
                        dialogStyle: UpgradeDialogStyle.cupertino,
                        upgrader: Upgrader(),
                        child: child!,
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
