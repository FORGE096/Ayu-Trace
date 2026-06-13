import 'package:hive_ce/hive.dart';

import '../../domain/entities/log_rule.dart';

part 'log_rule_model.g.dart';

@HiveType(typeId: 0)
class LogRuleModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String ruleName;
  @HiveField(2)
  final String pattern;
  @HiveField(3)
  final int severityIndex;
  @HiveField(4)
  final bool isRegex;
  @HiveField(5)
  final bool isActive;

  LogRuleModel({
    required this.id,
    required this.ruleName,
    required this.pattern,
    required this.severityIndex,
    required this.isRegex,
    required this.isActive,
  });

  LogRule toEntity() {
    return LogRule(
      id: id,
      ruleName: ruleName,
      pattern: pattern,
      severity: RuleSeverity.values[severityIndex],
      isRegex: isRegex,
      isActive: isActive,
    );
  }

  factory LogRuleModel.fromEntity(LogRule entity) {
    return LogRuleModel(
      id: entity.id,
      ruleName: entity.ruleName,
      pattern: entity.pattern,
      severityIndex: entity.severity.index,
      isRegex: entity.isRegex,
      isActive: entity.isActive,
    );
  }
}
