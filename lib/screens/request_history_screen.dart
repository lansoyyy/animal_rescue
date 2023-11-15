import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  final msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Request')
                  .where('uid',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return Center(
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
                      for (int i = 0; i < data.docs.length; i++)
                        Column(
                          children: [
                            const Divider(
                              color: Colors.black,
                            ),
                            ListTile(
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: '${data.docs[i]['msg']}',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Bold',
                                  ),
                                  TextWidget(
                                    text: DateFormat.yMMMd().add_jm().format(
                                        data.docs[i]['dateTime'].toDate()),
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Medium',
                                  ),
                                  TextWidget(
                                    text: 'Rescuer: ${data.docs[i]['name']}',
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Medium',
                                  ),
                                ],
                              ),
                              trailing: TextWidget(
                                text: '${data.docs[i]['status']}',
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
                );
              }),
        ),
      ),
    );
  }
}
