import 'dart:io';
import 'dart:convert';
import '../../domain/entities/log_entry.dart';
import '../models/log_process_request.dart';
import 'log_parser_helpers.dart';

/// Top-level function executed within a separate isolate.
///
/// Reads a large Minecraft log file efficiently using streams and chunking
/// to prevent memory exhaustion (RAM overflow). Parses each line and flags
/// suspicious activities based on [LogProcessRequest.dangerPatterns].
///
/// Returns a list of parsed [LogEntry] objects.
Future<List<LogEntry>> parseMinecraftLogIsolate(
  LogProcessRequest request,
) async {
  final file = File(request.filePath);
  final List<LogEntry> parsedLogs = [];

  // Stream is utilized to handle massive files (e.g., 500MB+) efficiently.
  final Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter());

  // Standard Minecraft Log Regex pattern
  // Example match: [14:32:01] [Server thread/INFO]: Done!
  final RegExp logRegex = RegExp(r'^\[(.*?)\] \[(.*?)\/(.*?)\]: (.*)$');

  await for (var line in lines) {
    if (line.trim().isEmpty) continue;

    final Match? match = logRegex.firstMatch(line);

    // Check if the line contains any user-defined or default danger patterns.
    final bool isFlagged = request.dangerPatterns.any(
      (pattern) => line.contains(pattern),
    );

    if (match != null) {
      parsedLogs.add(
        LogEntry(
          timestamp: match.group(1) ?? '',
          thread: match.group(2) ?? '',
          level: parseLogLevel(match.group(3)),
          message: match.group(4) ?? '',
          originalLine: line,
          isFlagged: isFlagged,
        ),
      );
    } else {
      // Handles unformatted lines, such as multiline error stack traces.
      parsedLogs.add(
        LogEntry(
          timestamp: '',
          thread: '',
          level: LogLevel.unknown,
          message: line,
          originalLine: line,
          isFlagged: isFlagged,
        ),
      );
    }
  }

  return parsedLogs;
}
