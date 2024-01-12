import 'package:animal_rescue/screens/auth/login_screen.dart';

import 'package:animal_rescue/services/add_user.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/textfield_widget.dart';
import '../admin/rescuer_list_screen.dart';

class SignupScreen extends StatefulWidget {
  bool inrescuer;
  bool? inadmin;

  SignupScreen({super.key, required this.inrescuer, this.inadmin = false});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  final dateController = TextEditingController();

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
                text: widget.inadmin! ? 'Register a Rescuer' : 'Register here',
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
                        width: 125,
                        label: 'First Name',
                        controller: fnameController,
                      ),
                      TextFieldWidget(
                        width: 80,
                        label: 'M.I',
                        controller: mnameController,
                      ),
                      TextFieldWidget(
                        width: 125,
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
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Select Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Bold',
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: '*',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Bold',
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            dateFromPicker(context);
                          },
                          child: SizedBox(
                            width: 325,
                            height: 50,
                            child: TextFormField(
                              enabled: false,
                              style: TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: primary,
                              ),

                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: primary,
                                ),
                                hintStyle: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                hintText: dateController.text,
                                border: InputBorder.none,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorStyle: const TextStyle(
                                    fontFamily: 'Bold', fontSize: 12),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),

                              controller: dateController,
                              // Pass the validator to the TextFormField
                            ),
                          ),
                        ),
                      ],
                    ),
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

  void dateFromPicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      String formattedDate = DateFormat('MMMM, dd, yyyy').format(pickedDate);

      setState(() {
        dateController.text = formattedDate;
      });
    } else {
      return null;
    }
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
          widget.inrescuer ? 'Rescuer' : 'User',
          dateController.text);

      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailController.text, password: passwordController.text);

      showToast('Account created succesfully!');

      if (widget.inadmin!) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AdminRescuerScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
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
