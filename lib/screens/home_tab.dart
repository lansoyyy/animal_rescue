import 'package:animal_rescue/screens/admin/admin_request_screen.dart';
import 'package:animal_rescue/screens/home_screen.dart';
import 'package:animal_rescue/screens/profile_screen.dart';
import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/screens/rescue_request_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  bool inrescuer;

  HomeTab({
    super.key,
    required this.inrescuer,
  });

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
      const RescueRequestScreen(),
      const RequestHistoryScreen(),
      const ProfileScreen(),
    ];

    final tabs1 = [
      const HomeScreen(),
      const AdminRequestScreen(),
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
            items: widget.inrescuer
                ? [
                    const BottomNavigationBarItem(
                        label: 'Home', icon: Icon(Icons.home)),
                    const BottomNavigationBarItem(
                        label: 'History', icon: Icon(Icons.history)),
                    const BottomNavigationBarItem(
                        label: 'Profile', icon: Icon(Icons.person)),
                  ]
                : [
                    const BottomNavigationBarItem(
                        label: 'Home', icon: Icon(Icons.home)),
                    const BottomNavigationBarItem(
                        label: 'Report', icon: Icon(Icons.add_circle_outlined)),
                    const BottomNavigationBarItem(
                        label: 'History', icon: Icon(Icons.history)),
                    const BottomNavigationBarItem(
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
          child:
              SafeArea(child: widget.inrescuer ? tabs1[_index] : tabs[_index]),
        ));
  }
}
