import 'package:flutter/material.dart';
import 'package:newsapp/helperFunctions/extention_theme_color_helperFunction.dart';

class ThemeModel {

 /// A model that provides the complete light and dark theme configurations for the app.
///
/// The [ThemeModel] class defines two [ThemeData] objects:
/// - [lightMode]: The theme used when the app is in light mode.
/// - [darkMode]: The theme used when the app is in dark mode.
///
/// Both themes include:
/// - `brightness`: Light or dark mode identifier.
/// - `primaryColor`: Main background or primary shade used across UI.
/// - `scaffoldBackgroundColor`: Background color for scaffold-level widgets.
/// - `appBarTheme`: Customizes the appearance of the AppBar, including background,
///   text style, icon color, and elevation.
/// - `textTheme`: Sets global text styles like headlines and body text.
/// - `colorScheme`: Provides colors for surfaces and interactive elements.
/// - `elevatedButtonTheme`: Uniform button styling with rounded corners and text style.
/// - `iconTheme`: Colors for icons throughout the app.
/// - `fontFamily`: Sets `'DMSans'` as the default font for the app.
/// - `extensions`: Uses [CustomThemeColors] to define app-specific colors like card backgrounds,
///   border colors, and search field backgrounds.
///
/// ### Usage:
/// This class is typically used when configuring `ThemeData` in the root `MaterialApp`.
/// You can toggle between `lightMode` and `darkMode` based on user preference or system theme.
///
/// ```dart
/// final theme = ThemeModel();
/// final ThemeData currentTheme = isDark ? theme.darkMode : theme.lightMode;
/// ```
///
/// See also:
/// - [CustomThemeColors] for the custom color extension used in both themes.

  /// The light theme configuration for the app.
  ///
  /// - Backgrounds are bright (`white`).
  /// - Text and icons are primarily black.
  /// - Card and border colors are soft and light.
  final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    extensions: [
      CustomThemeColors(
        newsCardColor: Color(0xFFF5F5F5),
        borderColor: Color(0xFFDDDDDD),
        searchFieldBg: Colors.grey[200]!,
      ),
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'DMSans',
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black, fontSize: 32),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
      secondary: Colors.amber,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    fontFamily: 'DMSans',
  );

  /// The dark theme configuration for the app.
  ///
  /// - Uses deep shades for background and surfaces.
  /// - Text and icons are white or amber for contrast.
  /// - Card and border colors are adjusted for dark backgrounds.
  final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFF121212),
    extensions: [
      CustomThemeColors(
        newsCardColor: Color(0xFF2C2C2C),
        borderColor: Color(0xFF555555),
        searchFieldBg: Colors.grey.shade800,
      ),
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'DMSans',
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white, fontSize: 32),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
    ).copyWith(
      secondary: Colors.amber,
      surface: const Color(0xFF121212),
      onSurface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.amber),
    fontFamily: 'DMSans',
  );
}
