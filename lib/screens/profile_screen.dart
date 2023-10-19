import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final contactnumberController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 75,
              ),
              TextWidget(
                text: 'Profile',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                minRadius: 50,
                maxRadius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  text: 'Change Profile Picture',
                  fontSize: 14,
                  fontFamily: 'Bold',
                  color: primary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(label: 'Name', controller: usernameController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(label: 'Email', controller: emailController),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                label: 'Password',
                controller: passwordController,
                isObscure: true,
                showEye: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                label: 'Address',
                controller: addressController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                  label: 'Phone Number', controller: contactnumberController),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                label: 'Edit Profile',
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                label: 'Save Profile',
                onPressed: () {},
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
}
