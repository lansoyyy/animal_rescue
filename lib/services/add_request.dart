import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addRequest(msg, img, double lat, double long, name) async {
  final docUser = FirebaseFirestore.instance.collection('Request').doc();

  final json = {
    'name': name,
    'msg': msg,
    'img': img,
    'lat': lat,
    'long': long,
    'dateTime': DateTime.now(),
    'type': 'User',
    'id': docUser.id,
    'status': 'Pending',
    'uid': FirebaseAuth.instance.currentUser!.uid,
  };

  await docUser.set(json);
}
