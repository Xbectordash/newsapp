import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_event.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_state.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  /// A [Bloc] that manages the app's theme state.
  ///
  /// The [ThemeBloc] listens for [ThemeChange] events and updates the [ThemeState]
  /// accordingly with the new `isLigthMode` value.
  ///
  /// ### Initial State:
  /// Emits [ThemeState] with `isLigthMode: true` (i.e., light mode enabled by default).
  ///
  /// ### Events Handled:
  /// - [ThemeChange] : Emits a new [ThemeState] with the updated theme mode.

  ThemeBloc() : super(ThemeState(isLigthMode: true)) {
    on<ThemeChange>((event, emit) {
      emit(ThemeState(isLigthMode: event.isLigthMode));
    });
  }
}
