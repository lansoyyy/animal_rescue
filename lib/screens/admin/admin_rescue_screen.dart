import 'dart:async';

import 'package:animal_rescue/screens/admin/admin_request_screen.dart';
import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/utils/colors.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminRescueScreen extends StatefulWidget {
  String id;

  AdminRescueScreen({super.key, required this.id});

  @override
  State<AdminRescueScreen> createState() => _AdminRescueScreenState();
}

class _AdminRescueScreenState extends State<AdminRescueScreen> {
  final msgController = TextEditingController();

  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  addMarker(double lat, double long) {
    markers.add(
      Marker(
        draggable: false,
        icon: BitmapDescriptor.defaultMarker,
        markerId: const MarkerId('my location'),
        position: LatLng(lat, long),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Request')
        .doc(widget.id)
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
            return Container(
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
                      TextWidget(
                        text: data['name'],
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                        text: data['msg'],
                        fontSize: 18,
                        fontFamily: 'Bold',
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 125,
                        width: 325,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data['img']),
                              fit: BoxFit.cover),
                        ),
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
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: GoogleMap(
                                markers: markers,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(data['lat'], data['long']),
                                  zoom: 14.4746,
                                ),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                              ),
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
                            data['status'] == 'Onging'
                                ? const SizedBox()
                                : Center(
                                    child: ButtonWidget(
                                      textColor: Colors.black,
                                      color: Colors.yellow[400],
                                      label: 'Mark as Ongoing',
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .doc(widget.id)
                                            .update({'status': 'Ongoing'});
                                        showToast('Marked as ongoing!');
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminRequestScreen()));
                                      },
                                    ),
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            data['status'] == 'Rescued'
                                ? const SizedBox()
                                : Center(
                                    child: ButtonWidget(
                                      label: 'Mark as Rescued',
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .doc(widget.id)
                                            .update({'status': 'Rescued'});
                                        showToast('Marked as rescued!');
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminRequestScreen()));
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
            );
          }),
    );
  }
}
