import 'package:birsu/core/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_helper.g.dart';

@riverpod
class StorageHelper extends _$StorageHelper {
  @override
  GetStorage build() {
    return GetStorage();
  }

  void setLightThemeTrue() {
    state.write(_isLightThemeKey, true);
  }

  void setLightThemeFalse() {
    state.write(_isLightThemeKey, false);
  }

  bool get isLightTheme {
    return state.read(_isLightThemeKey) ?? true;
  }

  String get _isLightThemeKey => AppConstants.isLightThemeKey;
}
