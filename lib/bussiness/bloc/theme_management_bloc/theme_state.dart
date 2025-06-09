import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  /// Represents the current theme mode of the app.
///
/// The [ThemeState] holds a single boolean value [isLigthMode] which indicates
/// whether the app is in light mode (`true`) or dark mode (`false`).
///
/// This class extends [Equatable] to allow easy comparison between states.
///
/// ### Example:
/// ```dart
/// final lightTheme = ThemeState(isLigthMode: true);
/// final darkTheme = ThemeState(isLigthMode: false);
/// ```

  final bool isLigthMode;
  /// Creates a [ThemeState] with the given [isLigthMode] value.
  const ThemeState({required this.isLigthMode});
  @override
  List<Object?> get props => [isLigthMode];
}
