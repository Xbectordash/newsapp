import 'package:flutter/material.dart';

@immutable
class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  final Color newsCardColor;
  final Color borderColor;
  final Color searchFieldBg;

  const CustomThemeColors({
    required this.newsCardColor,
    required this.borderColor,
    required this.searchFieldBg,
  });

  @override
  CustomThemeColors copyWith({
    Color? newsCardColor,
    Color? borderColor,
    Color? searchFieldBg,
  }) {
    return CustomThemeColors(
      newsCardColor: newsCardColor ?? this.newsCardColor,
      borderColor: borderColor ?? this.borderColor,
      searchFieldBg: searchFieldBg ?? this.searchFieldBg,
    );
  }

  @override
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) {
    if (other is! CustomThemeColors) return this;
    return CustomThemeColors(
      newsCardColor: Color.lerp(newsCardColor, other.newsCardColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      searchFieldBg: Color.lerp(searchFieldBg, other.searchFieldBg, t)!,
    );
  }
}
extension CustomColorGetter on BuildContext {
  CustomThemeColors get customColors =>
      Theme.of(this).extension<CustomThemeColors>()!;
}