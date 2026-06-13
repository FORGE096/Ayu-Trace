class LogRule {
  final String id;
  final String ruleName; // eg: Dangerous Commands or Coin Transactions
  final String pattern; // eg: "/op" or "Coins Added To %player%"
  final RuleSeverity severity;
  final bool isRegex; // eg: true if the user is using advanced Regex
  final bool isActive;

  LogRule({
    required this.id,
    required this.ruleName,
    required this.pattern,
    required this.severity,
    this.isRegex = false,
    this.isActive = true,
  });
}

enum RuleSeverity { info, warning, danger, analytic }
