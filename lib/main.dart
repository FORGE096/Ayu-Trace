import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'core/di/locator.dart';
import 'core/routes/app_router.dart';
import 'data/models/log_rule_model.dart';
import 'presentation/bloc/rules/rules_bloc.dart';
import 'presentation/bloc/rules/rules_event.dart';

void main() async {
  // Ensure Flutter bindings are initialized before calling async methods
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Database (Hive)
  await Hive.initFlutter();

  // Register Hive Adapters (Generated in previous steps)
  Hive.registerAdapter(LogRuleModelAdapter());

  // Setup Dependency Injection (GetIt)
  setupLocator();

  // Run the App
  runApp(const AyuTraceApp());
}

class AyuTraceApp extends StatelessWidget {
  const AyuTraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide the RulesBloc globally and load rules immediately
        BlocProvider<RulesBloc>(
          create: (_) => locator<RulesBloc>()..add(LoadRulesEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Ayu Trace',
        debugShowCheckedModeBanner: false,

        // Setup Dark Theme for Glassmorphism
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(
            0xFF0F172A,
          ), // Modern dark slate background
          fontFamily:
              'Inter', // Recommend adding a modern font like Inter or Roboto
        ),
        // GoRouter Configuration
        routerConfig: AppRouter.router,
      ),
    );
  }
}
