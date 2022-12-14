import 'package:circlink/services/auth.dart';
import 'package:circlink/widgets/bottom_navigation_bar.dart';
import 'package:circlink/widgets/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'views/login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: authMethods.getUser() != null ? const BottomNavbar() : const LoginScreen()
    );
  }
}
