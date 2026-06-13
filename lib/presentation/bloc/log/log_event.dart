import 'package:equatable/equatable.dart';
import '../../../domain/entities/log_rule.dart';

abstract class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object> get props => [];
}

class ProcessLogFileEvent extends LogEvent {
  final String filePath;
  final List<LogRule> activeRules;

  const ProcessLogFileEvent({
    required this.filePath,
    required this.activeRules,
  });

  @override
  List<Object> get props => [filePath, activeRules];
}
