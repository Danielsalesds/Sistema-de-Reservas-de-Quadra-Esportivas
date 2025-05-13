import "package:flutter/material.dart";

import "AppColors.dart";

class MaterialTheme {
  final TextTheme textTheme;

  MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff42617d),
      surfaceTint: Color(0xff42617d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa7c7e7),
      onPrimaryContainer: Color(0xff34536f),
      secondary: Color(0xff496177),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffbfd8f2),
      onSecondaryContainer: Color(0xff475e74),
      tertiary: Color(0xff53606a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd6e4f0),
      onTertiaryContainer: Color(0xff596670),
      error: Color(0xff8f4a4b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xfff7a1a1),
      onErrorContainer: Color(0xff743537),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1c),
      onSurfaceVariant: Color(0xff44474b),
      outline: Color(0xff74777b),
      outlineVariant: Color(0xffc4c7cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffaacaea),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xffaacaea),
      onPrimaryFixedVariant: Color(0xff294964),
      secondaryFixed: Color(0xffcde5ff),
      onSecondaryFixed: Color(0xff021d31),
      secondaryFixedDim: Color(0xffb0c9e3),
      onSecondaryFixedVariant: Color(0xff31495e),
      tertiaryFixed: Color(0xffd6e4f0),
      onTertiaryFixed: Color(0xff101d26),
      tertiaryFixedDim: Color(0xffbac8d4),
      onTertiaryFixedVariant: Color(0xff3b4852),
      surfaceDim: Color(0xffdcd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff0eded),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff173953),
      surfaceTint: Color(0xff42617d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff51708d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff20384d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff587086),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b3841),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff616f79),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5d2326),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa05859),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff33363a),
      outline: Color(0xff505356),
      outlineVariant: Color(0xff6a6d71),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffaacaea),
      primaryFixed: Color(0xff51708d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff385873),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff587086),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f576d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff616f79),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff495660),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c6),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdc),
      surfaceContainerHighest: Color(0xffd4d1d1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff092f48),
      surfaceTint: Color(0xff42617d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2c4c67),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff152e42),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff344b61),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff212e37),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3e4b54),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff50191c),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff753637),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292c30),
      outlineVariant: Color(0xff46494d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffaacaea),
      primaryFixed: Color(0xff2c4c67),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff12354f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff344b61),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1c3549),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3e4b54),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff27343d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b8),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f0f0),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF4A90E2),
      surfaceTint: Color(0xffaacaea),
      onPrimary: Color(0xFF1A1A1A),
      primaryContainer: Color(0xffa7c7e7),
      onPrimaryContainer: Color(0xff34536f),
      secondary: Color(0xffe9f3ff),
      onSecondary: Color(0xff1a3247),
      secondaryContainer: Color(0xffbfd8f2),
      onSecondaryContainer: Color(0xff475e74),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff25323b),
      tertiaryContainer: Color(0xffd6e4f0),
      onTertiaryContainer: Color(0xff596670),
      error: Color(0xffffc6c5),
      onError: Color(0xff561e20),
      errorContainer: Color(0xfff7a1a1),
      onErrorContainer: Color(0xff743537),
      surface: Color(0xff131313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7cb),
      outline: Color(0xff8e9195),
      outlineVariant: Color(0xff44474b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff42617d),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xffaacaea),
      onPrimaryFixedVariant: Color(0xff294964),
      secondaryFixed: Color(0xffcde5ff),
      onSecondaryFixed: Color(0xff021d31),
      secondaryFixedDim: Color(0xffb0c9e3),
      onSecondaryFixedVariant: Color(0xff31495e),
      tertiaryFixed: Color(0xffd6e4f0),
      onTertiaryFixed: Color(0xff101d26),
      tertiaryFixedDim: Color(0xffbac8d4),
      onTertiaryFixedVariant: Color(0xff3b4852),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1c),
      surfaceContainer: Color(0xff201f20),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7e2ff),
      surfaceTint: Color(0xffaacaea),
      onPrimary: Color(0xff032a44),
      primaryContainer: Color(0xffa7c7e7),
      onPrimaryContainer: Color(0xff143751),
      secondary: Color(0xffe9f3ff),
      onSecondary: Color(0xff1a3247),
      secondaryContainer: Color(0xffbfd8f2),
      onSecondaryContainer: Color(0xff2a4257),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff25323b),
      tertiaryContainer: Color(0xffd6e4f0),
      onTertiaryContainer: Color(0xff3c4953),
      error: Color(0xffffd2d1),
      onError: Color(0xff481316),
      errorContainer: Color(0xfff7a1a1),
      onErrorContainer: Color(0xff50191c),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadce0),
      outline: Color(0xffafb2b6),
      outlineVariant: Color(0xff8e9094),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff2b4b66),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001322),
      primaryFixedDim: Color(0xffaacaea),
      onPrimaryFixedVariant: Color(0xff173953),
      secondaryFixed: Color(0xffcde5ff),
      onSecondaryFixed: Color(0xff001322),
      secondaryFixedDim: Color(0xffb0c9e3),
      onSecondaryFixedVariant: Color(0xff20384d),
      tertiaryFixed: Color(0xffd6e4f0),
      onTertiaryFixed: Color(0xff05131b),
      tertiaryFixedDim: Color(0xffbac8d4),
      onTertiaryFixedVariant: Color(0xff2b3841),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1e),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe6f1ff),
      surfaceTint: Color(0xffaacaea),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa7c7e7),
      onPrimaryContainer: Color(0xff000e1b),
      secondary: Color(0xffe9f3ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbfd8f2),
      onSecondaryContainer: Color(0xff062236),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd6e4f0),
      onTertiaryContainer: Color(0xff1e2b34),
      error: Color(0xffffeceb),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffadad),
      onErrorContainer: Color(0xff220003),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef0f4),
      outlineVariant: Color(0xffc0c3c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff2b4b66),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffaacaea),
      onPrimaryFixedVariant: Color(0xff001322),
      secondaryFixed: Color(0xffcde5ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb0c9e3),
      onSecondaryFixedVariant: Color(0xff001322),
      tertiaryFixed: Color(0xffd6e4f0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbac8d4),
      onTertiaryFixedVariant: Color(0xff05131b),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff515050),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f20),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474647),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
    extensions: [
      // Adiciona aqui a extensão correta para esse esquema
      if (colorScheme.brightness == Brightness.light)
        const AppColors(
          textColor: Color(0xFF1A1A1A),
          descColor: Color(0xFF3A3A3A),
          baseColor: Color(0xFF42617D),
          cardColor: Color(0xffa7c7e7),
          buttonColor: Color(0xFF42617D),
          backgroundColor: Color(0xFFF5F7FA),
          onBaseColor: Color(0xffffffff),
          iconColor: Color(0xFF1A1A1A),
          // azul/laranja
          activeColor: Color(0xFFBBDEFB),
          inactiveColor: Color(0xFFFFCCBC),
          okBtnColor: Color(0xFF388E3C),
          cancelBtnColor:Color(0xFFD32F2F),
        )
      else
        const AppColors(
          textColor: Color(0xFFF5F5F5),
          descColor: Color(0xFFE0E0E0),
          baseColor: Color(0xFF4A90E2),
          cardColor: Color(0xFF4A90E2),
          buttonColor: Color(0xFF2F80ED),
          backgroundColor: Color(0xFF1C1C1E),
          onBaseColor: Color(0xFF1C1C1E),
          iconColor: Color(0xFFF5F5F5),
          activeColor: Color(0xFF2196F3),
          inactiveColor: Color(0xFFFFA000),
          okBtnColor: Color(0xFF81C784)	,
          cancelBtnColor:Color(0xFFEF9A9A),

        ),
    ],
  );

  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
