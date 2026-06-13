/// Represents the payload required to process a Minecraft log file inside an isolate.
///
/// Since isolates do not share memory, all required parameters
/// must be encapsulated within a single object to be passed via [compute].
class LogProcessRequest {
  /// The absolute file path of the Minecraft log file.
  final String filePath;

  /// A list of custom or default patterns/rules defined by the user.
  /// Used to flag dangerous or specific activities (e.g., "/op", "Coins Added").
  final List<String> dangerPatterns;

  const LogProcessRequest({
    required this.filePath,
    required this.dangerPatterns,
  });
}
