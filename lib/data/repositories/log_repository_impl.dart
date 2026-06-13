import 'package:flutter/foundation.dart';
import '../../domain/entities/log_entry.dart';
import '../../domain/repositories/log_repository.dart';
import '../../core/models/log_process_request.dart';
import '../../core/utils/log_isolate_processor.dart';

class LogRepositoryImpl implements LogRepository {
  @override
  Future<List<LogEntry>> processLogFile(
    String filePath,
    List<String> dangerRules,
  ) async {
    /// Create a request object to send to the isolate.
    /// We use named parameters here as defined in our new model.
    final request = LogProcessRequest(
      filePath: filePath,
      dangerPatterns: dangerRules,
    );

    /// The compute function runs 'parseMinecraftLogIsolate' in a separate thread.
    /// This ensures the UI remains fully responsive (no freezes),
    /// even when parsing massive log files (e.g., 500MB+).
    final result = await compute(parseMinecraftLogIsolate, request);

    return result;
  }
}
