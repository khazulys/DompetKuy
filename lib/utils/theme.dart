import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  static FThemeData darkTheme() {
    const colors = FColors(
      brightness: Brightness.dark,
      barrier: Color(0x33FFFFFF),
      background: black,
      foreground: white,
      primary: white,
      primaryForeground: black,
      secondary: gray800,
      secondaryForeground: white,
      muted: gray700,
      mutedForeground: gray300,
      border: gray800,
      destructive: gray400,
      destructiveForeground: white,
      error: gray400,
      errorForeground: white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );

    return FThemeData(
      colors: colors,
      typography: FTypography(
        defaultFontFamily: GoogleFonts.inter().fontFamily!,
        xs: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 12, height: 1),
        sm: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 14, height: 1.25),
        base: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 16, height: 1.5),
        lg: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 18, height: 1.75),
        xl: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 20, height: 1.75),
        xl2: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 24, height: 2),
        xl3: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 30, height: 2.25),
        xl4: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 36, height: 2.5),
        xl5: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 48, height: 3),
        xl6: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 60, height: 3.75),
        xl7: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 72, height: 4.5),
        xl8: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 96, height: 6),
      ),
    );
  }

  static FThemeData lightTheme() {
    const colors = FColors(
      brightness: Brightness.light,
      barrier: Color(0x33000000),
      background: white,
      foreground: black,
      primary: black,
      primaryForeground: white,
      secondary: gray200,
      secondaryForeground: black,
      muted: gray300,
      mutedForeground: gray700,
      border: gray300,
      destructive: gray600,
      destructiveForeground: white,
      error: gray600,
      errorForeground: white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );

    return FThemeData(
      colors: colors,
      typography: FTypography(
        defaultFontFamily: GoogleFonts.inter().fontFamily!,
        xs: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 12, height: 1),
        sm: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 14, height: 1.25),
        base: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 16, height: 1.5),
        lg: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 18, height: 1.75),
        xl: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 20, height: 1.75),
        xl2: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 24, height: 2),
        xl3: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 30, height: 2.25),
        xl4: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 36, height: 2.5),
        xl5: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 48, height: 3),
        xl6: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 60, height: 3.75),
        xl7: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 72, height: 4.5),
        xl8: TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 96, height: 6),
      ),
    );
  }
}
