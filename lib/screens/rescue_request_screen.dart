import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class RescueRequestScreen extends StatefulWidget {
  const RescueRequestScreen({super.key});

  @override
  State<RescueRequestScreen> createState() => _RescueRequestScreenState();
}

class _RescueRequestScreenState extends State<RescueRequestScreen> {
  final msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 75,
                ),
                TextWidget(
                  text: 'Request a Rescue',
                  fontSize: 18,
                  fontFamily: 'Bold',
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFieldWidget(
                  maxLine: 5,
                  height: 100,
                  controller: msgController,
                  label: 'Leave a short message',
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Upload a Photo',
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
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const ListTile(
                        tileColor: Colors.grey,
                        title: Icon(Icons.upload),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Location',
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
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Send Request to',
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
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/profile.png',
                                  height: 75,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                  text: 'John Doe',
                                  fontSize: 14,
                                  fontFamily: 'Bold',
                                ),
                              ],
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ButtonWidget(
                          label: 'Send Request',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const RequestHistoryScreen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
