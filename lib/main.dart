import 'package:farmgate/app.dart';
import 'package:farmgate/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(Application());
}
