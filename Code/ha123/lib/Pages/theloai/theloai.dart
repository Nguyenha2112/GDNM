import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Pages/theloai/TheLoaiDetailPage.dart';

class TheLoai extends StatefulWidget {
  @override
  _TheLoaiState createState() => _TheLoaiState();
}

class _TheLoaiState extends State<TheLoai> {
  final TextEditingController tenController = TextEditingController();
  String? coverImagePath;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        coverImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách thể loại',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
            () => GridView.builder(
          itemCount: 10, // Số lượng item hiển thị
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => TheLoaiDetailPage(tenTheLoai: '',));
              },
              child: Dismissible(
                key: Key(index.toString()),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await _confirmDeleteTheLoai(context);
                },
                onDismissed: (direction) {
                  // Thêm xử lý khi xóa thể loại
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: coverImagePath != null
                              ? Image.file(
                            File(coverImagePath!),
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            'Assets/Icons/default_image.png', // Đường dẫn tới ảnh mặc định
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            'Tên thể loại', // Thêm tên thể loại hoặc thay đổi theo dữ liệu thực
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTheLoaiDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTheLoaiDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm Thể Loại Mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: tenController,
                  decoration: InputDecoration(labelText: 'Tên Thể Loại'),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: coverImagePath != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(coverImagePath!),
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _confirmDeleteTheLoai(BuildContext context) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa thể loại này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Hủy', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
    return result;
  }
}
