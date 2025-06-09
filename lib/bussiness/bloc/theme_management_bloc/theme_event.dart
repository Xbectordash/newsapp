import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  /// Defines events related to theme management in the application, used with BLoC or similar state management.
  ///
  /// - [ThemeEvent]: The abstract base class for all theme-related events. Extends [Equatable]
  ///   to support value comparisons, enabling efficient state updates.
  /// - [ThemeChange]: A concrete event representing a change in theme mode (light or dark).
  ///   Contains a boolean [isLigthMode] to indicate the desired theme.
  ///
  /// This structure allows scalable and testable theme handling in reactive UI architectures.

  const ThemeEvent();
}

class ThemeChange extends ThemeEvent {
  final bool isLigthMode;
  const ThemeChange({required this.isLigthMode});
  @override
  List<Object?> get props => [isLigthMode];
}
