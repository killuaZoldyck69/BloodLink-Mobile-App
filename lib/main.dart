import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Supabase (replace the placeholders with your real keys)
  await Supabase.initialize(
    url: 'https://darcwfgciwzzpmgtaild.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhcmN3ZmdjaXd6enBtZ3RhaWxkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDk3MTMsImV4cCI6MjA4Mzg4NTcxM30.B0c8njA4B9caDGCoWLQ6iskbDC3UPC8bCXUbx0BPL_s',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Modern Medical Clean color palette
    const Color kBackground = Color(0xFFF9FAFB); // Off-White (60%)
    const Color kWhite = Color(0xFFFFFFFF);
    const Color kPrimaryRed = Color(0xFFE53935); // Medical Red (10%)
    const Color kDarkSlate = Color(0xFF1E293B); // Dark Slate Grey (30%)
    const Color kBlueGrey = Color(0xFF64748B); // Secondary / icons
    const Color kBorder = Color(0xFFE2E8F0); // Card / input border

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: kDarkSlate,
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
        color: kDarkSlate,
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: kDarkSlate,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        height: 1.5,
        color: kDarkSlate,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        height: 1.5,
        color: kDarkSlate,
      ),
    );

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: kPrimaryRed,
        onPrimary: kWhite,
        surface: kWhite,
        onSurface: kDarkSlate,
        secondary: kBlueGrey,
      ),
      scaffoldBackgroundColor: kBackground,
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: kWhite,
        foregroundColor: kDarkSlate,
        elevation: 0,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: kDarkSlate,
        ),
        iconTheme: IconThemeData(color: kBlueGrey),
      ),
      cardTheme: CardThemeData(
        color: kWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: kBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryRed,
          foregroundColor: kWhite,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kPrimaryRed,
          side: const BorderSide(color: kPrimaryRed, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          minimumSize: const Size(64, 56),
          textStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryRed, width: 2),
        ),
        labelStyle: TextStyle(color: kBlueGrey),
        hintStyle: TextStyle(color: kBlueGrey),
      ),
      iconTheme: IconThemeData(color: kBlueGrey),
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: kPrimaryRed,
        onPrimary: kWhite,
        secondary: kBlueGrey,
        surface: const Color(0xFF111827),
        onSurface: Colors.white,
      ),
      textTheme: appTextTheme.apply(bodyColor: Colors.white),
      scaffoldBackgroundColor: const Color(0xFF0F1724),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF0F1724),
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: kBlueGrey),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF0B1220),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF1F2937), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryRed,
          foregroundColor: kWhite,
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0B1220),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1F2937), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1F2937), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kPrimaryRed, width: 2),
        ),
        labelStyle: TextStyle(color: kBlueGrey),
        hintStyle: TextStyle(color: kBlueGrey),
      ),
      iconTheme: IconThemeData(color: kBlueGrey),
    );

    return MaterialApp.router(
      title: 'BloodLink',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
