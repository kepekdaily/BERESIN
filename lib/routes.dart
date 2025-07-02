import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/auth_screen.dart';
import 'screens/map_picker_screen.dart';
import 'screens/pesanan_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const AuthScreen(), 
  '/home': (context) => HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/map': (context) => const MapPickerScreen(),
  '/pesanan': (context) => const PesananScreen(),
};
