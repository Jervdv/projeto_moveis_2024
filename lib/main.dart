import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/firebase_options.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:projeto_moveis_2024/services/auth_service.dart';
import 'app/app.dart';
import 'package:provider/provider.dart';

class Title1 {
  String value = 'Deleted';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<Title1>(create: (_) => Title1()),
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => FuelEntriesRepository(auth: context.read<AuthService>())),
      ],
      child: const MyApp(),
    ),
  );
}
