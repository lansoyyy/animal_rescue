import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/drawer_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  List tabs = [
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: primary,
        ),
      ),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextWidget(
          text: 'Animal Rescue',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/dog.png',
                height: 350,
                width: 350,
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: 'Help',
                fontSize: 48,
                color: Colors.white,
                fontFamily: 'Bold',
              ),
              TextWidget(
                text: 'Animals',
                fontSize: 48,
                color: Colors.white,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: 'Bold', fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Bold', fontSize: 10),
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey[400],
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex != 0
                ? const Icon(Icons.home_outlined)
                : const Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex != 1
                ? const Icon(Icons.message_outlined)
                : const Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex != 1
                ? const Icon(Icons.person_3_outlined)
                : const Icon(Icons.person_3),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}