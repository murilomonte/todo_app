import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// To:Do
// Usar a paleta do luma

// ThemeData darkMode = ThemeData(
//   fontFamily: GoogleFonts.poppins().fontFamily,
//   colorScheme: ColorScheme.dark(
//     // background is deprecated
//     primary: Colors.white,
//     onPrimary: const Color(0xFF212121),
//     secondary: Colors.grey.shade800,
//     onSecondary: Colors.white,
//     error: Colors.red.shade900,
//     onError: Colors.white,
//     surface: const Color(0xFF242424),
//     onSurface: Colors.white,
//   ),
// );


ThemeData darkMode = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  disabledColor: Colors.grey.shade700,
  hintColor: Colors.grey.shade500,
  focusColor: Colors.white12,
  hoverColor: Colors.white10,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffa9c7ff),
    surfaceTint: Color(0xffa9c7ff),
    onPrimary: Color(0xff08305f),
    primaryContainer: Color(0xff264777),
    onPrimaryContainer: Color(0xffd6e3ff),
    secondary: Color(0xffa9c7ff),
    onSecondary: Color(0xff09305f),
    secondaryContainer: Color(0xff274777),
    onSecondaryContainer: Color(0xffd6e3ff),
    tertiary: Color(0xff85d2e8),
    onTertiary: Color(0xff003641),
    tertiaryContainer: Color(0xff004e5d),
    onTertiaryContainer: Color(0xffafecff),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffdad6),
    surface: Color(0xFF111111),
    onSurface: Color(0xffe2e2e9),
    onSurfaceVariant: Color(0xffc4c6cf),
    outline: Color(0xff8e9099),
    outlineVariant: Color(0xff43474e),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xffe2e2e9),
    inversePrimary: Color(0xff405f90),
    primaryFixed: Color(0xffd6e3ff),
    onPrimaryFixed: Color(0xff001b3d),
    primaryFixedDim: Color(0xffa9c7ff),
    onPrimaryFixedVariant: Color(0xff264777),
    secondaryFixed: Color(0xffd6e3ff),
    onSecondaryFixed: Color(0xff001b3d),
    secondaryFixedDim: Color(0xffa9c7ff),
    onSecondaryFixedVariant: Color(0xff274777),
    tertiaryFixed: Color(0xffafecff),
    onTertiaryFixed: Color(0xff001f26),
    tertiaryFixedDim: Color(0xff85d2e8),
    onTertiaryFixedVariant: Color(0xff004e5d),
    surfaceDim: Color(0xff111318),
    surfaceBright: Color(0xff37393e),
    surfaceContainerLowest: Color(0xff0c0e13),
    surfaceContainerLow: Color(0xff191c20),
    surfaceContainer: Color(0xFF1C1C1C), // c11
    surfaceContainerHigh: Color(0xFF1C1C1C), // c11
    surfaceContainerHighest: Color(0xFF1C1C1C) // c11
  ),
);