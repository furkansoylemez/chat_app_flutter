import 'package:birsu/app/app.dart';
import 'package:birsu/core/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await _initialize();
  runApp(const ProviderScope(child: App()));
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
