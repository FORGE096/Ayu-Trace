import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Note: You will need to create these screen files later
// import '../../presentation/screens/home_screen.dart';
// import '../../presentation/screens/settings_screen.dart';

/// Centralized router configuration for Ayu Trace using GoRouter.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen (Glassmorphism goes here)')),
        ), // Placeholder until we build HomeScreen
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
