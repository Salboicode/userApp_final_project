// ignore_for_file: unused_import
import 'dart:io';
import 'package:final_project/Cubits/auth_cubit.dart';
import 'package:final_project/Home_layout.dart';
import 'package:final_project/Screens/Home_screen.dart';
import 'package:final_project/firebase_options.dart';
import 'package:final_project/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/auth_screens/login.dart';
import 'package:final_project/auth_screens/Signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? const HomeLayout() : const LoginScreen(),
    );
  }
}
