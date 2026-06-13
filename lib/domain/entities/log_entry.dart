class LogEntry {
  final String timestamp;
  final String thread;
  final LogLevel level;
  final String message;
  final String originalLine;
  final bool isFlagged;

  const LogEntry({
    required this.timestamp,
    required this.thread,
    required this.level,
    required this.message,
    required this.originalLine,
    this.isFlagged = false,
  });
}

enum LogLevel { info, warning, error, fatal, unknown }
