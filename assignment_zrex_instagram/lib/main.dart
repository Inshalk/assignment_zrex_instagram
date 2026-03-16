import 'package:assignment_zrex_instagram/provider/user_provider.dart';
import 'package:assignment_zrex_instagram/view/screens/authentication_screens/login_screen.dart';
import 'package:assignment_zrex_instagram/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
   child:  MyApp()
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final user= ref.watch(userProvider);
    return MaterialApp(
      theme: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
  ),
  themeMode: ThemeMode.system,
      title: 'Instagram',
      home:(user != null && user.token.isNotEmpty)? const MainScreen():const LoginScreen(),    
      
    );
  }
}