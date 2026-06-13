import '../entities/log_entry.dart';

abstract class LogRepository {
  /// read the log file and return a list of LogEntry objects
  Future<List<LogEntry>> processLogFile(
    String filePath,
    List<String> dangerRules,
  );
}
