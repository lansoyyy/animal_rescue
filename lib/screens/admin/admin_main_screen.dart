import 'package:animal_rescue/screens/admin/admin_request_screen.dart';
import 'package:animal_rescue/screens/auth/signup_screen.dart';
import 'package:animal_rescue/screens/home_screen.dart';
import 'package:animal_rescue/utils/colors.dart';

import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset(
                'assets/images/Logo.png',
                width: 350,
                height: 250,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminRequestScreen()));
              },
              leading: CircleAvatar(
                  minRadius: 50,
                  maxRadius: 50,
                  child: Image.asset('assets/images/jay.png')),
              title: TextWidget(
                text: 'Jay Lorence Pati-on',
                fontSize: 18,
                color: primary,
                fontFamily: 'Bold',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminRequestScreen()));
              },
              leading: CircleAvatar(
                  minRadius: 50,
                  maxRadius: 50,
                  child: Image.asset('assets/images/loy.png')),
              title: TextWidget(
                text: 'Leonil Lugod',
                fontSize: 18,
                color: primary,
                fontFamily: 'Bold',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminRequestScreen()));
              },
              leading: CircleAvatar(
                  minRadius: 50,
                  maxRadius: 50,
                  child: Image.asset('assets/images/sar.png')),
              title: TextWidget(
                text: 'Sarfeil Dave Curran',
                fontSize: 18,
                color: primary,
                fontFamily: 'Bold',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // login(context) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordController.text);
  //     showToast('Logged in succesfully!');
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const HomeScreen()));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       showToast("No user found with that email.");
  //     } else if (e.code == 'wrong-password') {
  //       showToast("Wrong password provided for that user.");
  //     } else if (e.code == 'invalid-email') {
  //       showToast("Invalid email provided.");
  //     } else if (e.code == 'user-disabled') {
  //       showToast("User account has been disabled.");
  //     } else {
  //       showToast("An error occurred: ${e.message}");
  //     }
  //   } on Exception catch (e) {
  //     showToast("An error occurred: $e");
  //   }
  // }
}
