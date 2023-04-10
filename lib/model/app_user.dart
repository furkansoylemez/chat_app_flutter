import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });
  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      uid: doc['uid'] as String,
      name: doc['name'] as String,
      email: doc['email'] as String,
      photoUrl: doc['photoUrl'] as String? ?? '',
    );
  }

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
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
