import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC9lEsaUYXvWoWkXLe5FV5RD-NVBc3tUjM',
      appId: '1:207440694897:android:6e747783b055ac1a7fd5d0',
      messagingSenderId: '207440694897',
      projectId: 'gastrip-1b263',
      storageBucket: 'gastrip-1b263.appspot.com',
    )
  );


  runApp(
    MultiProvider(
      providers: [
        Provider<Title1>(create: (_) => Title1()),
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (_) => FuelEntriesRepository()),
      ],
      child: const MyApp(),
    ),
  );
}
