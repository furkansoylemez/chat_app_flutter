import 'package:birsu/core/app_constants.dart';
import 'package:birsu/core/app_exception.dart';
import 'package:birsu/model/user_model.dart';
import 'package:birsu/provider/firebase_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_users.g.dart';

@riverpod
class GetUsers extends _$GetUsers {
  @override
  void build() {}

  Future<List<UserModel>> action() async {
    try {
      final firebaseFirestore = ref.read(firebaseFirestoreProvider);
      final querySnapshot = await firebaseFirestore
          .collection(AppConstants.usersCollection)
          .get();
      return querySnapshot.docs.map(UserModel.fromDocument).toList();
    } catch (error) {
      throw AppException(error.toString());
    }
  }
}
