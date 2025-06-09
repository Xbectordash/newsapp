

import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChange extends ThemeEvent {
  final bool isLigthMode;
  const ThemeChange({required this.isLigthMode});
  @override
  List<Object?> get props => [isLigthMode];
}
