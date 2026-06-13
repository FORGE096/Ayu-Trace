import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
// Note: You will need to create these screen files later
// import '../../presentation/screens/settings_screen.dart';

/// Centralized router configuration for Ayu Trace using GoRouter.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings Screen (Rules setup)')),
        ), // Placeholder until we build SettingsScreen
      ),
    ],
  );
}
