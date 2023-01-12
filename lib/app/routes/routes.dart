import 'package:go_router/go_router.dart';
import 'package:scoreboard_desktop/home/home.dart';

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      // GoRoute(
      //   path: '/settings',
      //   builder: (context, state) => const SettingsPage(),
      // ),
    ],
    debugLogDiagnostics: true,
  );
}
