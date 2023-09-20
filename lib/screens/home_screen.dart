import 'package:animal_rescue/screens/main_home_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'assets/images/illu.png',
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
              ButtonWidget(
                color: Colors.white,
                textColor: Colors.green,
                label: 'Get Started',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MainHomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}