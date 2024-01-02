import 'package:animal_rescue/screens/home_screen.dart';
import 'package:animal_rescue/screens/profile_screen.dart';
import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/screens/rescue_request_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _index = 0;

  late dynamic userData1 = {};

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const HomeScreen(),
      const RequestHistoryScreen(),
      const RescueRequestScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
        bottomNavigationBar: Material(
          elevation: 0,
          color: Colors.black,
          child: BottomNavigationBar(
            currentIndex: _index,
            selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'QBold',
                color: Colors.black),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'QRegular',
                color: Colors.black),
            unselectedItemColor: Colors.grey,
            selectedItemColor: primary,
            items: const [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'History', icon: Icon(Icons.history)),
              BottomNavigationBarItem(
                  label: 'Report', icon: Icon(Icons.add_circle_outlined)),
              BottomNavigationBarItem(
                  label: 'Profile', icon: Icon(Icons.person)),
            ],
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Gray.png'), fit: BoxFit.cover),
          ),
          child: SafeArea(child: tabs[_index]),
        ));
  }
}
