import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/screens/welcom_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Message Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: WelcomScreen.TAG,
      routes: {
        WelcomScreen.TAG : (context) => WelcomScreen(),
        SignInScreen.TAG : (context) => SignInScreen(),
        RegistrationScreen.TAG : (context) => RegistrationScreen(),
        ChatScreen.TAG : (context) => ChatScreen(),

      },
    );
  }
}