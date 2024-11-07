import 'package:meapsbook/Config/Themes.dart';
import 'package:meapsbook/Pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EBOOK',
      theme: lightTheme, // Kiểm tra lightTheme có được định nghĩa trong Themes.dart
      home: LoginPage(), // Đặt LoginPage làm trang chính
    );
  }
}
