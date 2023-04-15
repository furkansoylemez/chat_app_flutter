import 'dart:io';

import 'package:birsu/usecase/upload_picture.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drawer_upload_picture.g.dart';

@riverpod
class DrawerUploadPicture extends _$DrawerUploadPicture {
  @override
  Future<void> build() async {}

  Future<void> uploadPicture(File picture) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(uploadPictureProvider).action(picture);
    });
  }
}
