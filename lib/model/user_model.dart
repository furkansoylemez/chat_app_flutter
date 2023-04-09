import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'] as String,
      name: doc['name'] as String,
      email: doc['email'] as String,
      photoUrl: doc['photoUrl'] as String? ?? '',
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
}
