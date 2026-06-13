import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/rule_repository.dart';
import 'rules_event.dart';
import 'rules_state.dart';

/// Manages the state of log filtering rules using the BLoC pattern.
class RulesBloc extends Bloc<RulesEvent, RulesState> {
  final RuleRepository repository;

  RulesBloc({required this.repository}) : super(RulesInitial()) {
    on<LoadRulesEvent>(_onLoadRules);
    on<AddOrUpdateRuleEvent>(_onAddOrUpdateRule);
    on<DeleteRuleEvent>(_onDeleteRule);
  }

  Future<void> _onLoadRules(
    LoadRulesEvent event,
    Emitter<RulesState> emit,
  ) async {
    emit(RulesLoading());
    try {
      // First, ensure default rules exist (e.g., /op, Coins Added)
      await repository.initializeDefaults();
      final rules = await repository.getAllRules();
      emit(RulesLoaded(rules));
    } catch (e) {
      emit(RulesError("Failed to load rules: ${e.toString()}"));
    }
  }

  Future<void> _onAddOrUpdateRule(
    AddOrUpdateRuleEvent event,
    Emitter<RulesState> emit,
  ) async {
    try {
      await repository.saveRule(event.rule);
      // Reload rules after saving to update the UI
      add(LoadRulesEvent());
    } catch (e) {
      emit(RulesError("Failed to save rule: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteRule(
    DeleteRuleEvent event,
    Emitter<RulesState> emit,
  ) async {
    try {
      await repository.deleteRule(event.ruleId);
      // Reload rules after deletion
      add(LoadRulesEvent());
    } catch (e) {
      emit(RulesError("Failed to delete rule: ${e.toString()}"));
    }
  }
}
