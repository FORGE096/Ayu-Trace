import '../../domain/entities/log_rule.dart';
import '../../domain/repositories/rule_repository.dart';
import '../datasources/rule_local_datasource.dart';
import '../models/log_rule_model.dart';

class RuleRepositoryImpl implements RuleRepository {
  final RuleLocalDataSource localDataSource;

  RuleRepositoryImpl({required this.localDataSource});

  @override
  Future<List<LogRule>> getAllRules() async {
    final ruleModels = await localDataSource.getRules();
    // Convert Hive models back to Domain entities
    return ruleModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveRule(LogRule rule) async {
    // Convert Domain entity to Hive model before saving
    final ruleModel = LogRuleModel.fromEntity(rule);
    await localDataSource.saveRule(ruleModel);
  }

  @override
  Future<void> deleteRule(String id) async {
    await localDataSource.deleteRule(id);
  }

  @override
  Future<void> initializeDefaults() async {
    await localDataSource.initDefaultRules();
  }
}
