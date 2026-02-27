import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/landing/landing_view.dart';

class SparcheApp extends StatelessWidget {
  const SparcheApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Sparche — All-in-One Shopping Companion',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const LandingView(),
    );
  }

  ThemeData _buildTheme() => ThemeData(
    brightness: Brightness.light,

    // Primary font: DM Sans (body, UI labels, buttons) 
    fontFamily: 'DMSans',

    // Colour scheme 
    colorScheme: ColorScheme.fromSeed(
      seedColor:   const Color(0xFF6120E2),
      brightness:  Brightness.light,
      primary:     const Color(0xFF6120E2),
      secondary:   const Color(0xFF8B52F5),
      surface:     const Color(0xFFFFFFFF),
      onPrimary:   Colors.white,
      onSurface:   const Color(0xFF1A1025),
    ),

    scaffoldBackgroundColor: const Color(0xFFFDFAF5),
    canvasColor:             const Color(0xFFFDFAF5),

    // AppBar 
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFDFAF5),
      foregroundColor: Color(0xFF1A1025),
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: Color(0xFF1A1025),
      ),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6120E2),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    // Text theme 
    textTheme: const TextTheme(
      // Display — hero headlines (DM Serif Display) 
      displayLarge: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontWeight: FontWeight.w400, // serifs look best at regular weight
        fontSize: 72,
        letterSpacing: -2.0,
        height: 0.96,
        color: Color(0xFF1A1025),
      ),
      displayMedium: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontWeight: FontWeight.w400,
        fontSize: 54,
        letterSpacing: -1.5,
        height: 1.0,
        color: Color(0xFF1A1025),
      ),

      // Headline — section titles
      headlineLarge: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontWeight: FontWeight.w400,
        fontSize: 42,
        letterSpacing: -1.0,
        height: 1.1,
        color: Color(0xFF1A1025),
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontWeight: FontWeight.w400,
        fontSize: 32,
        letterSpacing: -.5,
        height: 1.15,
        color: Color(0xFF1A1025),
      ),
      headlineSmall: TextStyle(
        fontFamily: 'DMSerifDisplay',
        fontWeight: FontWeight.w400,
        fontSize: 24,
        letterSpacing: -.3,
        color: Color(0xFF1A1025),
      ),

      // Title — card headers, nav labels 
      titleLarge: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        letterSpacing: -.2,
        color: Color(0xFF1A1025),
      ),
      titleMedium: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xFF1A1025),
      ),

      // Body — paragraph text
      bodyLarge: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w400,
        fontSize: 17,
        height: 1.75,
        color: Color(0xFF4A3D66),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w400,
        fontSize: 15,
        height: 1.7,
        color: Color(0xFF4A3D66),
      ),

      // Label — tags, overlines 
      labelLarge: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w700,
        fontSize: 13,
        letterSpacing: .2,
        color: Color(0xFF6120E2),
      ),
      labelSmall: TextStyle(
        fontFamily: 'DMSans',
        fontWeight: FontWeight.w600,
        fontSize: 10,
        letterSpacing: 2.5,
        color: Color(0xFF8C7AAD),
      ),
    ),

    useMaterial3: true,
  );
}