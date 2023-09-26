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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextWidget(
            text: 'Profile',
            fontSize: 18,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          const CircleAvatar(
            minRadius: 50,
            maxRadius: 50,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(label: 'Username', controller: usernameController),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(label: 'Email', controller: emailController),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
              label: 'Phone Number', controller: contactnumberController),
          const SizedBox(
            height: 30,
          ),
          ButtonWidget(
            label: 'Update',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
