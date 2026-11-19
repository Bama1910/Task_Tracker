import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import 'home_page.dart';


const Color kBHitam = Color(0xFF000000);
const Color kKartu = Color(0xFF1C1C1E);
const Color kGaris = Color(0xFF2C2C2E);
const Color kBorderInput = Color(0xFF3A3A3C);
const Color kPutih = Color(0xFFFFFFFF);
const Color kTeksSekunder = Color(0xFF8E8E93);
const Color kAksen = Color(0xFFFFD60A);

void main() {
  runApp(const MiniTaskApp());
}

ThemeData themeNotes() {
  final ColorScheme skema = ColorScheme.fromSeed(
    seedColor: kAksen,
    brightness: Brightness.dark,
  ).copyWith(
    surface: kBHitam,
    onSurface: kPutih,
    surfaceContainerHighest: kKartu,
    outline: kBorderInput,
    outlineVariant: kGaris,
    primary: kAksen,
    onPrimary: kBHitam,
    onSurfaceVariant: kTeksSekunder,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: skema,
    scaffoldBackgroundColor: kBHitam,
    appBarTheme: AppBarTheme(
      backgroundColor: kBHitam,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: kPutih,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: kGaris,
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorderInput),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorderInput),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kAksen, width: 1.5),
      ),
      hintStyle: const TextStyle(color: kTeksSekunder),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kAksen,
        side: const BorderSide(color: kBorderInput),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        minimumSize: const Size(0, 48),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kAksen,
        foregroundColor: kBHitam,
        shape: const StadiumBorder(),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: kTeksSekunder),
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return states.contains(WidgetState.selected) ? kAksen : null;
        },
      ),
      checkColor: WidgetStateProperty.all<Color?>(kBHitam),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: kKartu,
      contentTextStyle: const TextStyle(color: kPutih),
      actionTextColor: kAksen,
      behavior: SnackBarBehavior.floating,
    ),
    iconTheme: const IconThemeData(color: kTeksSekunder),
  );
}

class MiniTaskApp extends StatelessWidget {
  const MiniTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Harian',
      theme: themeNotes(),
      home: const HomePage(),
    );
  }
}
