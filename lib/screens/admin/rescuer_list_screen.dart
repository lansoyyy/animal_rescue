import 'package:animal_rescue/screens/admin/rescuer_profile_screen.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';

class AdminRescuerScreen extends StatefulWidget {
  const AdminRescuerScreen({super.key});

  @override
  State<AdminRescuerScreen> createState() => _AdminRescuerScreenState();
}

class _AdminRescuerScreenState extends State<AdminRescuerScreen> {
  final msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignupScreen(
                      inadmin: true,
                      inrescuer: true,
                    )));
          }),
      body: Container(
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('type', isEqualTo: 'Rescuer')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }

              final data = snapshot.requireData;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/sar.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextWidget(
                                    text: 'Administrator',
                                    fontSize: 18,
                                    fontFamily: 'Bold',
                                    color: primary,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                              'Logout Confirmation',
                                              style: TextStyle(
                                                  fontFamily: 'QBold',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to Logout?',
                                              style: TextStyle(
                                                  fontFamily: 'QRegular'),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text(
                                                  'Close',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () async {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginScreen()));
                                                },
                                                child: const Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                                icon: Icon(
                                  Icons.logout,
                                  color: primary,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextWidget(
                          text: 'Registered Rescuers',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        for (int i = 0; i < data.docs.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RescuerProfileScreen(
                                          id: data.docs[i].id,
                                        )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    text: '${i + 1}. ${data.docs[i]['name']}',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Bold',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
