import 'package:animal_rescue/screens/aboutus_screen.dart';
import 'package:animal_rescue/screens/auth/login_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutusScreen()));
                },
                icon: Icon(
                  Icons.info_rounded,
                  color: primary,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Logout Confirmation',
                              style: TextStyle(
                                  fontFamily: 'QBold',
                                  fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              'Are you sure you want to Logout?',
                              style: TextStyle(fontFamily: 'QRegular'),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                      fontFamily: 'QRegular',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontFamily: 'QRegular',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ));
                },
                icon: Icon(
                  Icons.logout,
                  color: primary,
                  size: 32,
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(
              'assets/images/Logo.png',
              width: 300,
              height: 125,
            ),
          ),
          CarouselSlider(
              items: [
                Center(
                  child: Image.asset(
                    'assets/images/dog.png',
                    width: 450,
                    height: 400,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/1.jpg',
                    width: 450,
                    height: 400,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/2.jpg',
                    width: 450,
                    height: 400,
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ))
        ],
      ),
    );
  }
}
