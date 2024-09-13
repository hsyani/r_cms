// File: /lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:r_cms_v_3_0/screens/init_screen.dart';
import 'package:r_cms_v_3_0/screens/manager_home_screen.dart';
import 'package:r_cms_v_3_0/screens/worker_home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/admin_screen.dart';
import 'l10n/l10n.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  // 창 설정
  WindowOptions windowOptions = const WindowOptions(
    size: Size(720, 1280), // 창 기본 크기
    center: true, // 화면 가운데 위치
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // 전체 화면 크기로 설정, 상태바 유지
    await windowManager.setSize(const Size(720, 1280)); // 원하는 화면 크기로 설정
    await windowManager.setPosition(Offset.zero); // 창 위치를 화면의 좌상단으로 설정
    windowManager.show();
  });
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const InitScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const WorkerHomeScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/workerhome',
        builder: (context, state) => const WorkerHomeScreen(),
      ),
      GoRoute(
        path: '/manager',
        builder: (context, state) => const ManagerHomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
