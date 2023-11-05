import 'package:data/data.dart';

import 'app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthService.initializeFirebase();

  runApp(const MyApp());
}
