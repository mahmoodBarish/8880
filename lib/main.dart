import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/my_app.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/my_app',
  routes: <RouteBase>[
    GoRoute(
      path: '/my_app',
      builder: (BuildContext context, GoRouterState state) {
        return const MyApp();
      },
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
