import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_bloc.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_event.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_state.dart';


class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return IconButton(
          tooltip: state.isLigthMode ? 'Switch to Dark Mode' : 'Switch to Light Mode',
          icon: Icon(state.isLigthMode ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            context.read<ThemeBloc>().add(
              ThemeChange(isLigthMode: !state.isLigthMode),
            );
          },
        );
      },
    );
  }
}
