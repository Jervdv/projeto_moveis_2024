import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/screens/dashboard_screen.dart';
import 'package:projeto_moveis_2024/screens/login_screen.dart';
import 'package:projeto_moveis_2024/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    }

    if (auth.usuario == null) return LoginScreen();

    return DashboardScreen();
  }
}

loading() {
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    )
  );
}
