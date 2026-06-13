import 'package:equatable/equatable.dart';
import '../../../domain/entities/log_rule.dart';

abstract class RulesState extends Equatable {
  const RulesState();

  @override
  List<Object> get props => [];
}

class RulesInitial extends RulesState {}

class RulesLoading extends RulesState {}

class RulesLoaded extends RulesState {
  final List<LogRule> rules;
  const RulesLoaded(this.rules);

  @override
  List<Object> get props => [rules];
}

class RulesError extends RulesState {
  final String message;
  const RulesError(this.message);

  @override
  List<Object> get props => [message];
}
