import 'package:final_exam/presentation/screens/expenses_screen.dart';
import 'package:final_exam/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (_) => LoginScreen());
    } else if (settings.name == "/expenses_screen") {
      String userId = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => ExpensesScreen(userId: userId));
    } else {
      return null;
    }
  }
}
