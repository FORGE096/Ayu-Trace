import '../../domain/entities/log_entry.dart';

/// Parses the string representation of a Minecraft log level into a [LogLevel] enum.
///
/// Returns [LogLevel.unknown] if the severity string is unrecognized or null.
LogLevel parseLogLevel(String? levelStr) {
  if (levelStr == null) return LogLevel.unknown;

  switch (levelStr.toUpperCase()) {
    case 'INFO':
      return LogLevel.info;
    case 'WARN':
      return LogLevel.warning;
    case 'ERROR':
      return LogLevel.error;
    case 'FATAL':
      return LogLevel.fatal;
    default:
      return LogLevel.unknown;
  }
}
