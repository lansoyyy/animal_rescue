import 'package:animal_rescue/screens/home_tab.dart';

import 'package:animal_rescue/services/add_user.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';
import '../admin/rescuer_list_screen.dart';

class SignupScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mnameController = TextEditingController();
  final contactnumberController = TextEditingController();
  final purokController = TextEditingController();
  final brgyController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();
  final yearController = TextEditingController();

  bool inrescuer;
  bool? inadmin;

  SignupScreen({super.key, required this.inrescuer, this.inadmin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: TextWidget(
                text: inadmin! ? 'Register a Rescuer' : 'Register here',
                fontSize: 24,
                fontFamily: 'Bold',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(
                      text: 'Name',
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFieldWidget(
                        width: 150,
                        label: 'First Name',
                        controller: fnameController,
                      ),
                      TextFieldWidget(
                        width: 50,
                        label: 'M.I',
                        controller: mnameController,
                      ),
                      TextFieldWidget(
                        width: 150,
                        label: 'Last Name',
                        controller: lnameController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(
                      text: 'Address',
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFieldWidget(
                        width: 175,
                        label: 'Purok/Street/Zone',
                        controller: purokController,
                      ),
                      TextFieldWidget(
                        width: 175,
                        label: 'Barangay',
                        controller: brgyController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFieldWidget(
                        width: 175,
                        label: 'Municiplaity/City',
                        controller: cityController,
                      ),
                      TextFieldWidget(
                        width: 175,
                        label: 'Province',
                        controller: provinceController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(
                      text: 'Birthdate',
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFieldWidget(
                        width: 150,
                        label: 'Month',
                        controller: monthController,
                      ),
                      TextFieldWidget(
                        inputType: TextInputType.number,
                        width: 50,
                        label: 'Day',
                        controller: dayController,
                      ),
                      TextFieldWidget(
                        inputType: TextInputType.number,
                        width: 150,
                        label: 'Year',
                        controller: yearController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(
                      text: 'Login details',
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFieldWidget(
                      label: 'Email',
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFieldWidget(
                      isObscure: true,
                      label: 'Password',
                      controller: passwordController,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ButtonWidget(
                color: primary,
                label: 'Signup',
                onPressed: () {
                  register(context);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      addUser(
          '${fnameController.text} ${mnameController.text}. ${lnameController.text}',
          contactnumberController.text,
          '${purokController.text}, ${brgyController.text}, ${cityController.text}, ${provinceController.text}',
          emailController.text,
          inrescuer ? 'Rescuer' : 'User',
          '${monthController.text}, ${dayController.text}, ${yearController.text}');

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');

      if (inadmin!) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AdminRescuerScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeTab(
                  inrescuer: inrescuer,
                )));
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeTab(
                inrescuer: inrescuer,
              )));
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
