import 'package:animal_rescue/screens/admin/admin_rescue_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminRequestScreen extends StatefulWidget {
  String selected;

  AdminRequestScreen({super.key, required this.selected});

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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Request')
                .where('selected', isEqualTo: widget.selected)
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
              return SingleChildScrollView(
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
                      for (int i = 0; i < data.docs.length; i++)
                        Column(
                          children: [
                            const Divider(
                              color: Colors.black,
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AdminRescueScreen(
                                          id: data.docs[i].id,
                                        )));
                              },
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
                                    text:
                                        'Rescuer: ${data.docs[i]['selected']}',
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
                ),
              );
            }),
      ),
    );
  }
}
