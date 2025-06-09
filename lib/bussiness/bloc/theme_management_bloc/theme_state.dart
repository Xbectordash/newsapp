import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool isLigthMode;
  const ThemeState({required this.isLigthMode});
  @override
  List<Object?> get props => [isLigthMode];
}
