// ignore_for_file: file_names

import 'package:final_project/Cubits/home_cubit.dart';
import 'package:final_project/Cubits/profile_cubit.dart';
import 'package:final_project/Screens/Home_screen.dart';
import 'package:final_project/Screens/profile_screen.dart';
import 'package:final_project/auth_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileCubit()..getUserDataFromFireStoreDataBase(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..getCategoriseFromDatabase(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'ICT Hub',
            style: TextStyle(
              color:  Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold
            ),
            ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 114, 58, 124),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                });
              },
              icon: const Icon(
                Icons.login_outlined,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: const Color.fromARGB(255, 206, 206, 206),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 114, 58, 124),
        ),
      ),
    );
  }
}
