import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meapsbook/Components/BookTile.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Pages/BookDetails/BookDetails.dart';

class TheLoaiDetailPage extends StatefulWidget {
  final String tenTheLoai;

  TheLoaiDetailPage({required this.tenTheLoai});

  @override
  _TheLoaiDetailPageState createState() => _TheLoaiDetailPageState();
}

class _TheLoaiDetailPageState extends State<TheLoaiDetailPage> {
  @override
  void initState() {
    super.initState();
    // Gọi dữ liệu từ database dựa theo thể loại nếu cần thiết
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Các sách có thể loại ${widget.tenTheLoai}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10, // Thay 10 bằng số lượng sách thực tế
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => BookDetails()); // Điều hướng tới trang chi tiết sách
            },

          );
        },
      ),
    );
  }
}
