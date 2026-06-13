import 'package:get_it/get_it.dart';
import '../../data/datasources/rule_local_datasource.dart';
import '../../data/repositories/log_repository_impl.dart';
import '../../data/repositories/rule_repository_impl.dart';
import '../../domain/repositories/log_repository.dart';
import '../../domain/repositories/rule_repository.dart';
import '../../presentation/bloc/log/log_bloc.dart';
import '../../presentation/bloc/rules/rules_bloc.dart';

/// Global instance of GetIt for Dependency Injection
final GetIt locator = GetIt.instance;

/// Initializes all dependencies across Data, Domain, and Presentation layers.
/// Call this function inside main.dart before runApp().
void setupLocator() {
  // ---------------------------------------------------------------------------
  // 1. Data Sources
  // ---------------------------------------------------------------------------
  locator.registerLazySingleton<RuleLocalDataSource>(
    () => RuleLocalDataSourceImpl(),
  );

  // ---------------------------------------------------------------------------
  // 2. Repositories
  // ---------------------------------------------------------------------------
  locator.registerLazySingleton<RuleRepository>(
    () => RuleRepositoryImpl(localDataSource: locator()),
  );

  locator.registerLazySingleton<LogRepository>(() => LogRepositoryImpl());

  // ---------------------------------------------------------------------------
  // 3. BLoCs
  // ---------------------------------------------------------------------------
  // BLoCs are registered as Factory so a new instance is provided if needed,
  // though typically in standard apps we provide them globally.
  locator.registerFactory<RulesBloc>(() => RulesBloc(repository: locator()));
  locator.registerFactory<LogBloc>(() => LogBloc(logRepository: locator()));
}
