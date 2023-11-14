import 'package:animal_rescue/screens/admin/admin_rescue_screen.dart';
import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AdminRequestScreen extends StatefulWidget {
  const AdminRequestScreen({super.key});

  @override
  State<AdminRequestScreen> createState() => _AdminRequestScreenState();
}

class _AdminRequestScreenState extends State<AdminRequestScreen> {
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
                  text: 'Request History',
                  fontSize: 18,
                  fontFamily: 'Bold',
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: TextWidget(
                    text: 'Request Details',
                    fontSize: 18,
                    color: primary,
                    fontFamily: 'Bold',
                  ),
                  trailing: TextWidget(
                    text: 'Status',
                    fontSize: 18,
                    color: primary,
                    fontFamily: 'Bold',
                  ),
                ),
                for (int i = 0; i < 5; i++)
                  Column(
                    children: [
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AdminRescueScreen()));
                        },
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Request a Rescue',
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Bold',
                            ),
                            TextWidget(
                              text: '10/06/2023 10:00 AM',
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Rescuer: Jay Lorence Pati-on',
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                        trailing: TextWidget(
                          text: 'Pending',
                          fontSize: 14,
                          color: primary,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
