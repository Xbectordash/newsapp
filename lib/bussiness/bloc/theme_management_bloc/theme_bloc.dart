
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_event.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isLigthMode: true)) {
    on<ThemeChange>((event, emit) {
      emit(ThemeState(isLigthMode: event.isLigthMode));
    });
  }
}
