import 'package:animal_rescue/screens/admin/admin_request_screen.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/textfield_widget.dart';

class AdminPasswordScreen extends StatefulWidget {
  String user;
  String img;
  String name;

  AdminPasswordScreen(
      {super.key, required this.user, required this.img, required this.name});

  @override
  State<AdminPasswordScreen> createState() => _AdminPasswordScreenState();
}

class _AdminPasswordScreenState extends State<AdminPasswordScreen> {
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                widget.img,
                width: 325,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: widget.name,
              fontSize: 24,
              fontFamily: 'Bold',
            ),
            const SizedBox(
              height: 50,
            ),
            TextFieldWidget(
              isObscure: true,
              label: 'Password',
              controller: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
              label: 'Login',
              onPressed: () {
                if (passwordController.text != '${widget.user}123') {
                  showToast('Incorrect password!');
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AdminRequestScreen(
                            selected: widget.user,
                          )));
                }
                // login(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
