import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:ntodotxt/misc.dart';

final ThemeData light = CustomTheme.light;
final ThemeData dark = CustomTheme.dark;

/// Customize versions of the theme data.
final ThemeData lightTheme = light.copyWith(
  appBarTheme: light.appBarTheme.copyWith(
    backgroundColor: Colors.transparent,
  ),
  splashColor: PlatformInfo.isAppOS ? Colors.transparent : null,
  chipTheme: light.chipTheme.copyWith(
    backgroundColor: light.dividerColor,
    shape: const StadiumBorder(),
  ),
  expansionTileTheme: light.expansionTileTheme.copyWith(
    collapsedBackgroundColor: light.appBarTheme.backgroundColor,
  ),
  listTileTheme: light.listTileTheme.copyWith(
    selectedColor: light.textTheme.bodySmall?.color,
    selectedTileColor: light.hoverColor,
  ),
  inputDecorationTheme: light.inputDecorationTheme.copyWith(
    filled: false,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: light.primaryColor),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: light.colorScheme.error),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: light.dividerColor),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: light.dividerColor),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: light.disabledColor),
    ),
  ),
);
final ThemeData darkTheme = dark.copyWith(
  appBarTheme: dark.appBarTheme.copyWith(
    backgroundColor: Colors.transparent,
  ),
  splashColor: PlatformInfo.isAppOS ? Colors.transparent : null,
  chipTheme: dark.chipTheme.copyWith(
    backgroundColor: dark.dividerColor,
    shape: const StadiumBorder(),
  ),
  expansionTileTheme: dark.expansionTileTheme.copyWith(
    collapsedBackgroundColor: dark.appBarTheme.backgroundColor,
  ),
  listTileTheme: dark.listTileTheme.copyWith(
    selectedColor: dark.textTheme.bodySmall?.color,
    selectedTileColor: PlatformInfo.isAppOS ? Colors.red : dark.hoverColor,
  ),
  inputDecorationTheme: dark.inputDecorationTheme.copyWith(
    filled: false,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: dark.primaryColor),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: dark.colorScheme.error),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: dark.dividerColor),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: dark.dividerColor),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: dark.disabledColor),
    ),
  ),
);

// Theme config for FlexColorScheme version 7.3.x. Make sure you use
// same or higher package version, but still same major version. If you
// use a lower package version, some properties may not be supported.
// In that case remove them after copying this theme to your app.
class CustomTheme {
  static ThemeData get light {
    return FlexThemeData.light(
      scheme: FlexScheme.bahamaBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  static ThemeData get dark {
    return FlexThemeData.dark(
      scheme: FlexScheme.bahamaBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
