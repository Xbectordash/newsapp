import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_bloc.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_event.dart';
import 'package:newsapp/bussiness/bloc/theme_management_bloc/theme_state.dart';


class ThemeToggleButton extends StatelessWidget {
  /// A toggle button for switching between Light and Dark themes using BLoC pattern.
///
/// This widget uses a [BlocBuilder] to listen to the [ThemeBloc] and rebuild the
/// icon based on the current [ThemeState]. It toggles between light and dark mode
/// using an [IconButton] that triggers a [ThemeChange] event on tap.
///
/// ### Features:
/// - Displays a sun icon (`Icons.light_mode`) when in light mode.
/// - Displays a moon icon (`Icons.dark_mode`) when in dark mode.
/// - Shows a tooltip to indicate the toggle action (e.g., "Switch to Dark Mode").
///
/// ### Usage:
/// ```dart
/// ThemeToggleButton()
/// ```
///
/// ### Dependencies:
/// - [ThemeBloc], [ThemeEvent], and [ThemeState] for managing theme state.
/// - Requires [ThemeChange] event to handle mode switching.
///
/// ### Example:
/// Add this widget to an AppBar or anywhere appropriate in your UI to allow the
/// user to switch the app theme dynamically.
///
/// ```dart
/// AppBar(
///   actions: [
///     ThemeToggleButton(),
///   ],
/// )
/// ```
///

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
