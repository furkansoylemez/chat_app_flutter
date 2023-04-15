import 'dart:io';

import 'package:birsu/core/app_exception.dart';
import 'package:birsu/provider/firebase_auth.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:birsu/provider/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_picture.g.dart';

@riverpod
UploadPicture uploadPicture(UploadPictureRef ref) {
  return UploadPicture(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    firebaseStorage: ref.watch(firebaseStorageProvider),
  );
}

class UploadPicture {
  UploadPicture({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  Future<void> action(File picture) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      final fileName = 'profilePictures/${currentUser?.uid}.jpg';
      final ref = firebaseStorage.ref().child(fileName);
      final uploadTask = ref.putFile(picture);
      final taskSnapshot = await uploadTask.whenComplete(() {});
      final photoUrl = await taskSnapshot.ref.getDownloadURL();
      await currentUser!.updatePhotoURL(photoUrl);
      await firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .update({'photoUrl': photoUrl});
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}
