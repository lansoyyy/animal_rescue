import 'dart:async';

import 'package:animal_rescue/screens/request_history_screen.dart';
import 'package:animal_rescue/services/add_request.dart';
import 'package:animal_rescue/widgets/button_widget.dart';
import 'package:animal_rescue/widgets/text_widget.dart';
import 'package:animal_rescue/widgets/textfield_widget.dart';
import 'package:animal_rescue/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';

class RescueRequestScreen extends StatefulWidget {
  const RescueRequestScreen({super.key});

  @override
  State<RescueRequestScreen> createState() => _RescueRequestScreenState();
}

class _RescueRequestScreenState extends State<RescueRequestScreen> {
  @override
  void initState() {
    super.initState();
    determinePosition();
    addMarker();
  }

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  String selected = '';

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
            .ref('Photo/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Photo/$fileName')
            .getDownloadURL();

        showToast('Image uploaded!');

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

  final msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      body: hasLoaded
          ? Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://www.youtube.com/watch?v=3LzNQY3aT4c');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          icon: const Icon(
                            Icons.info_outline_rounded,
                          ),
                        ),
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
                      GestureDetector(
                        onTap: () {
                          uploadPicture('gallery');
                        },
                        child: Padding(
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
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                onCameraMove: (position) {
                                  setState(() {
                                    lat = position.target.latitude;
                                    long = position.target.longitude;
                                  });
                                },
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(lat, long),
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Send Request to:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Bold',
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           selected = 'Jay';
                      //         });
                      //         showToast('Selected: $selected');
                      //       },
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           CircleAvatar(
                      //               minRadius: 35,
                      //               maxRadius: 35,
                      //               child:
                      //                   Image.asset('assets/images/jay.png')),
                      //           const SizedBox(
                      //             height: 5,
                      //           ),
                      //           TextWidget(
                      //             text: 'Jay',
                      //             fontSize: 14,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           selected = 'Leonil';
                      //         });
                      //         showToast('Selected: $selected');
                      //       },
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           CircleAvatar(
                      //               minRadius: 35,
                      //               maxRadius: 35,
                      //               child:
                      //                   Image.asset('assets/images/loy.png')),
                      //           const SizedBox(
                      //             height: 5,
                      //           ),
                      //           TextWidget(
                      //             text: 'Leonil',
                      //             fontSize: 14,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           selected = 'Sarfeil';
                      //         });
                      //         showToast('Selected: $selected');
                      //       },
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           CircleAvatar(
                      //               minRadius: 35,
                      //               maxRadius: 35,
                      //               child:
                      //                   Image.asset('assets/images/sar.png')),
                      //           const SizedBox(
                      //             height: 5,
                      //           ),
                      //           TextWidget(
                      //             text: 'Sarfeil',
                      //             fontSize: 14,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10,
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
                            StreamBuilder<DocumentSnapshot>(
                                stream: userData,
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('Something went wrong'));
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  }
                                  dynamic data = snapshot.data;
                                  return Center(
                                    child: ButtonWidget(
                                      color: primary,
                                      label: 'Send Request',
                                      onPressed: () {
                                        addRequest(msgController.text, imageURL,
                                            lat, long, data['name'], selected);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RequestHistoryScreen()));
                                      },
                                    ),
                                  );
                                }),
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  double lat = 0;
  double long = 0;

  bool hasLoaded = false;

  Set<Marker> markers = {};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  addMarker() {
    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;

        markers.add(
          Marker(
            draggable: true,
            onDrag: (value) {
              setState(() {
                lat = value.latitude;
                long = value.longitude;
              });
            },
            icon: BitmapDescriptor.defaultMarker,
            markerId: const MarkerId('my location'),
            position: LatLng(position.latitude, position.longitude),
          ),
        );
        hasLoaded = true;
      });
    }).catchError((error) {
      print('Error getting location: $error');
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
