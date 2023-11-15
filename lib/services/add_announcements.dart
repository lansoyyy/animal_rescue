import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, number, address, email) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'number': number,
    'address': address,
    'email': email,
    'dateTime': DateTime.now(),
    'type': 'User',
    'id': docUser.id,
  };

  await docUser.set(json);
}
