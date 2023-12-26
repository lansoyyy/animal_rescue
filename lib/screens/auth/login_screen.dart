import 'package:animal_rescue/screens/admin/admin_main_screen.dart';
import 'package:animal_rescue/screens/auth/signup_screen.dart';
import 'package:animal_rescue/screens/home_tab.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

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
            TextFieldWidget(
              label: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              isObscure: true,
              label: 'Password',
              controller: passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              color: primary,
              label: 'Login',
              onPressed: () {
                // login(context);
                login(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'Not registered?',
                  fontSize: 12,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignupScreen()));
                  },
                  child: TextWidget(
                    fontFamily: 'Bold',
                    text: 'Signup now',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdminMainScreen()));
              },
              child: TextWidget(
                fontFamily: 'Bold',
                text: 'Continue as Admin',
                fontSize: 14,
                color: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      showToast('Logged in succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeTab()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
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
