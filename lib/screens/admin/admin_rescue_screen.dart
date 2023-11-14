import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AdminRescueScreen extends StatefulWidget {
  const AdminRescueScreen({super.key});

  @override
  State<AdminRescueScreen> createState() => _AdminRescueScreenState();
}

class _AdminRescueScreenState extends State<AdminRescueScreen> {
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
                  height: 50,
                ),
                TextWidget(
                  text: 'Request details',
                  fontSize: 18,
                  fontFamily: 'Bold',
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFieldWidget(
                  isEnabled: false,
                  controller: msgController,
                  label: 'Requester Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  isEnabled: false,
                  controller: msgController,
                  label: 'Message',
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 125,
                  width: 325,
                  color: Colors.black,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ButtonWidget(
                          textColor: Colors.black,
                          color: Colors.yellow[400],
                          label: 'Mark as Ongoing',
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         const RequestHistoryScreen()));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ButtonWidget(
                          label: 'Mark as Rescued',
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         const RequestHistoryScreen()));
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
