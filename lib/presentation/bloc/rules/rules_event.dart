import 'package:equatable/equatable.dart';
import '../../../domain/entities/log_rule.dart';

abstract class RulesEvent extends Equatable {
  const RulesEvent();

  @override
  List<Object> get props => [];
}

class LoadRulesEvent extends RulesEvent {}

class AddOrUpdateRuleEvent extends RulesEvent {
  final LogRule rule;
  const AddOrUpdateRuleEvent(this.rule);

  @override
  List<Object> get props => [rule];
}

class DeleteRuleEvent extends RulesEvent {
  final String ruleId;
  const DeleteRuleEvent(this.ruleId);

  @override
  List<Object> get props => [ruleId];
}
