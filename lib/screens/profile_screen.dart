import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            dynamic data = snapshot.data;

            usernameController.text = data['name'];
            addressController.text = data['address'];
            contactnumberController.text = data['number'];

            return SizedBox(
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
                    TextFieldWidget(
                        label: 'Name', controller: usernameController),
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
                        label: 'Phone Number',
                        controller: contactnumberController),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      color: primary,
                      label: 'Edit Profile',
                      onPressed: () async {
                        await FirebaseFirestore.instance.doc(data.id).update({
                          'name': usernameController.text,
                          'address': addressController.text,
                          'number': contactnumberController.text
                        });
                        showToast('Profile updated succesfully!');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
