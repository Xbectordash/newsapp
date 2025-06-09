/// A utility class that provides a human-readable relative time string
/// (e.g., "5 minutes ago", "2 weeks ago") from a given ISO 8601 date string.
class CreatedAgo {
  /// Converts a given [dateStr] in ISO 8601 format into a relative time string
  /// such as "3 minutes ago", "2 days ago", etc.
  ///
  /// If [dateStr] is `null`, an empty string is returned.
  ///
  /// Example:
  /// ```dart
  /// CreatedAgo().timeAgo("2025-06-08T12:00:00Z");
  /// // Output: "1 day ago"
  /// ```
  ///
  /// The breakdown of return format is as follows:
  /// - < 60 seconds: "x seconds ago"
  /// - < 60 minutes: "x minutes ago"
  /// - < 24 hours: "x hours ago"
  /// - < 7 days: "x days ago"
  /// - < 30 days: "x weeks ago"
  /// - < 365 days: "x months ago"
  /// - ≥ 365 days: "x years ago"
  String timeAgo(String? dateStr) {
    if (dateStr == null) {
      return "";
    }

    DateTime dateTime = DateTime.parse(dateStr).toLocal();
    final Duration diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} seconds ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 30) {
      int weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      int years = (diff.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }
}
