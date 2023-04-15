import 'dart:io';

import 'package:birsu/core/extension/context_extensions.dart';
import 'package:birsu/feature/drawer/logic/drawer_logout.dart';
import 'package:birsu/feature/drawer/logic/drawer_upload_picture.dart';
import 'package:birsu/feature/drawer/view/drawer_list_tile.dart';
import 'package:birsu/feature/drawer/view/theme_switch_button.dart';
import 'package:birsu/provider/app_user.dart';
import 'package:birsu/widgets/custom_spacer.dart';
import 'package:birsu/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DrawerPage extends ConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);
    final logoutStatus = ref.watch(drawerLogoutProvider);
    final pictureStatus = ref.watch(drawerUploadPictureProvider);
    return Drawer(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Builder(
                      builder: (context) {
                        if (pictureStatus is AsyncLoading) {
                          return CircleAvatar(
                            radius: 35.r,
                            child: const CircularProgressIndicator(),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            _pickImage(
                              context,
                              ref,
                            );
                          },
                          child: Stack(
                            children: [
                              UserAvatar(
                                radius: 35.r,
                                imageUrl: appUser?.photoUrl ?? '',
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Badge(
                                  largeSize: 25.r,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  label: Icon(
                                    Icons.add,
                                    size: 16.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Text(
                      appUser?.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (logoutStatus is AsyncLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DrawerListTile(
                    title: context.loc.logout,
                    iconData: Icons.logout,
                    onTap: () {
                      ref.read(drawerLogoutProvider.notifier).logout();
                    },
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          const ThemeSwitchButton(),
          CustomSpacer.column(20.h)
        ],
      ),
    );
  }

  Future<void> _pickImage(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final currentTheme = Theme.of(context).colorScheme;
    final loc = context.loc;
    final picker = ImagePicker();
    final cropper = ImageCropper();
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final croppedImage = await cropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarWidgetColor: currentTheme.primary,
              hideBottomControls: true,
              backgroundColor: currentTheme.secondary,
              toolbarColor: currentTheme.background,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              toolbarTitle: loc.cropPicture,
            ),
          ],
        );

        if (croppedImage != null) {
          final croppedImageFile = File(croppedImage.path);
          await ref
              .read(drawerUploadPictureProvider.notifier)
              .uploadPicture(croppedImageFile);
        }
      }
    } catch (e) {
      //no need extra action.
    }
  }
}
