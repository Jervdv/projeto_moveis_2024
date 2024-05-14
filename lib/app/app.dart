import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/screens/history_screen.dart';
import 'package:projeto_moveis_2024/screens/login_screen.dart';
import 'package:projeto_moveis_2024/widgets/auth_check.dart';
import '../screens/dashboard_screen.dart';
import '../screens/new_entry_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthCheck(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/new_entry': (context) => NewEntryScreen(),
        '/history': (context) => const HistoryScreen(),
      },
    );
  }
}
