import 'package:meapsbook/Config/Themes.dart';
import 'package:meapsbook/Pages/SplacePage/SplacePage.dart';
import 'package:meapsbook/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext 
  context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' MEAPSBOOK',
      theme: lightTheme,
      home:const SplacePage(),
    );
  }
}
