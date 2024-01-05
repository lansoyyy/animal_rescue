import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, number, address, email, type) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'number': number,
    'address': address,
    'email': email,
    'dateTime': DateTime.now(),
    'type': type,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'id': docUser.id,
  };

  await docUser.set(json);
}
