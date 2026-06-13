import 'package:equatable/equatable.dart';
import '../../../domain/entities/log_entry.dart';

abstract class LogState extends Equatable {
  const LogState();

  @override
  List<Object> get props => [];
}

class LogInitial extends LogState {}

class LogProcessing extends LogState {}

class LogProcessSuccess extends LogState {
  final List<LogEntry> logs;

  const LogProcessSuccess(this.logs);

  @override
  List<Object> get props => [logs];
}

class LogProcessError extends LogState {
  final String message;

  const LogProcessError(this.message);

  @override
  List<Object> get props => [message];
}
