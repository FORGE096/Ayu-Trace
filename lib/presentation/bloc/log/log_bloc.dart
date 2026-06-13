import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/log_repository.dart';
import 'log_event.dart';
import 'log_state.dart';

/// Manages the state of parsing and displaying Minecraft log files.
class LogBloc extends Bloc<LogEvent, LogState> {
  final LogRepository logRepository;

  LogBloc({required this.logRepository}) : super(LogInitial()) {
    on<ProcessLogFileEvent>(_onProcessLogFile);
  }

  Future<void> _onProcessLogFile(
    ProcessLogFileEvent event,
    Emitter<LogState> emit,
  ) async {
    emit(LogProcessing());
    try {
      // Extract string patterns from the active rules defined by the user
      final dangerPatterns = event.activeRules
          .map((rule) => rule.pattern)
          .toList();

      // Send to the repository (which uses our heavy-lifting Isolate)
      final parsedLogs = await logRepository.processLogFile(
        event.filePath,
        dangerPatterns,
      );

      emit(LogProcessSuccess(parsedLogs));
    } catch (e) {
      emit(LogProcessError("Failed to parse log: ${e.toString()}"));
    }
  }
}
