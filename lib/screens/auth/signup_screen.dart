import 'package:animal_rescue/screens/home_tab.dart';
import 'package:animal_rescue/services/add_announcements.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';

class SignupScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final contactnumberController = TextEditingController();
  final addressController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextWidget(
                text: 'Register here',
                fontSize: 24,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Contact Number',
                controller: contactnumberController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                label: 'Address',
                controller: addressController,
              ),
              const SizedBox(
                height: 20,
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
                label: 'Signup',
                onPressed: () {
                  register(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // add

      addUser(nameController.text, contactnumberController.text,
          addressController.text, emailController.text);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeTab()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
