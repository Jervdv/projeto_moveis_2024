import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/new_entry_screen.dart';
import '../screens/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(entries: []),
      routes: {
        '/new_entry': (context) => NewEntryScreen(),
        // '/third': (context) => ThirdScreen(),
      },
    );
  }
}
