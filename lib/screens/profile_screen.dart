import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import '../widgets/toast_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  final name = TextEditingController();
  final address = TextEditingController();
  final bday = TextEditingController();

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Users/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Users/$fileName')
            .getDownloadURL();

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePicture': imageURL});

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

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

            name.text = data['name'];
            address.text = data['address'];
            bday.text = data['bday'];

            fnameController.text = name.text.split(' ')[0];
            mnameController.text = name.text.split(' ')[1];
            lnameController.text = name.text.split(' ')[2];

            purokController.text = address.text.split(',')[0];
            brgyController.text = address.text.split(',')[1];
            cityController.text = address.text.split(',')[2];
            provinceController.text = address.text.split(',')[3];

            monthController.text = bday.text.split(',')[0];
            dayController.text = bday.text.split(',')[1];
            yearController.text = bday.text.split(',')[2];
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
                    CircleAvatar(
                      minRadius: 50,
                      maxRadius: 50,
                      backgroundImage: NetworkImage(data['profilePicture']),
                    ),
                    TextButton(
                      onPressed: () {
                        uploadPicture('gallery');
                      },
                      child: TextWidget(
                        text: 'Change Profile Picture',
                        fontSize: 14,
                        fontFamily: 'Bold',
                        color: primary,
                      ),
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
                                label: 'Municipality/City',
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
                                width: 125,
                                label: 'Month',
                                controller: monthController,
                              ),
                              TextFieldWidget(
                                inputType: TextInputType.number,
                                width: 85,
                                label: 'Day',
                                controller: dayController,
                              ),
                              TextFieldWidget(
                                inputType: TextInputType.number,
                                width: 125,
                                label: 'Year',
                                controller: yearController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      color: primary,
                      label: 'Edit Profile',
                      onPressed: () async {
                        final fname = fnameController.text.split(' ')[0];

                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(data.id)
                            .update({
                          'name':
                              '$fname ${mnameController.text[0]}. ${lnameController.text}',
                          'address':
                              '${purokController.text}, ${brgyController.text}, ${cityController.text}, ${provinceController.text}',
                          'bday':
                              '${monthController.text}, ${dayController.text}, ${yearController.text}'
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
