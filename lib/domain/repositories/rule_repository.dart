import '../entities/log_rule.dart';

/// Abstract interface for managing user-defined and default log rules.
/// Defines the contract for data operations in the Domain layer.
abstract class RuleRepository {
  /// Fetches all active and inactive rules.
  Future<List<LogRule>> getAllRules();

  /// Saves a new rule or updates an existing one.
  Future<void> saveRule(LogRule rule);

  /// Deletes a rule by its unique identifier.
  Future<void> deleteRule(String id);

  /// Initializes default rules (e.g., /op command) if no rules exist.
  Future<void> initializeDefaults();
}
