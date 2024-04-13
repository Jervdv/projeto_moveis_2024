import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'app/app.dart';
import 'package:provider/provider.dart';

class Title1 {
  String value = 'Deleted';
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Title1>(create: (_) => Title1()),
        ChangeNotifierProvider(create: (_) => FuelEntriesRepository()),
      ],
      child: const MyApp(),
    ),
  );
}
