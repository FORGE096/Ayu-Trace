import 'package:hive_ce/hive.dart';

import '../models/log_rule_model.dart';

abstract class RuleLocalDataSource {
  Future<List<LogRuleModel>> getRules();
  Future<void> saveRule(LogRuleModel rule);
  Future<void> deleteRule(String id);
  Future<void> initDefaultRules();
}

class RuleLocalDataSourceImpl implements RuleLocalDataSource {
  static const String boxName = 'log_rules_box';

  @override
  Future<List<LogRuleModel>> getRules() async {
    final box = await Hive.openBox<LogRuleModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> saveRule(LogRuleModel rule) async {
    final box = await Hive.openBox<LogRuleModel>(boxName);
    await box.put(rule.id, rule);
  }

  @override
  Future<void> deleteRule(String id) async {
    final box = await Hive.openBox<LogRuleModel>(boxName);
    await box.delete(id);
  }

  @override
  Future<void> initDefaultRules() async {
    final box = await Hive.openBox<LogRuleModel>(boxName);

    if (box.isEmpty) {
      final defaultRules = [
        LogRuleModel(
          id: 'def_1',
          ruleName: 'OP Command',
          pattern: '/op',
          severityIndex: 2,
          isRegex: false,
          isActive: true,
        ),
        LogRuleModel(
          id: 'def_2',
          ruleName: 'Minecraft OP',
          pattern: '/minecraft:op',
          severityIndex: 2,
          isRegex: false,
          isActive: true,
        ),
        LogRuleModel(
          id: 'def_3',
          ruleName: 'Economy Transaction',
          pattern: 'Coins Added To',
          severityIndex: 3,
          isRegex: false,
          isActive: true,
        ),
      ];

      for (var rule in defaultRules) {
        await box.put(rule.id, rule);
      }
    }
  }
}
