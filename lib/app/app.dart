import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:projeto_moveis_2024/screens/fuel_entry_details_screen.dart';
import 'package:projeto_moveis_2024/screens/history_screen.dart';
import 'package:projeto_moveis_2024/screens/login_screen.dart';
import 'package:projeto_moveis_2024/widgets/auth_check.dart';
import '../screens/dashboard_screen.dart';
import '../screens/new_entry_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: Colors.lightBlue.shade200,
        backgroundColor: Colors.lightBlue.shade50,
        dividerColor: Colors.blue,
        todayForegroundColor: WidgetStateColor.resolveWith(
          (states) => Colors.blue,
        ),
        todayBackgroundColor: WidgetStateColor.resolveWith(
          (states) => Colors.blue.shade100,
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: WidgetStateColor.resolveWith(
            (states) => Colors.blue,
          ),
        ),
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStateColor.resolveWith(
            (states) => Colors.blue,
          ),
        ),
      ),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: AuthCheck(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/new_entry': (context) => NewEntryScreen(),
        '/history': (context) => const HistoryScreen(),
        '/details': (context) {
          final entry = ModalRoute.of(context)!.settings.arguments as FuelEntry;
          return FuelEntryDetailsScreen(entry: entry);
        },
      },
    );
  }
}
