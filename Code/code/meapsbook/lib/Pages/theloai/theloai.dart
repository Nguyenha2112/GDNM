import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Controller/TheLoaiController.dart';
import 'package:meapsbook/Models/TheLoaiModel.dart';
import 'package:meapsbook/Pages/theloai/TheLoaiDetailPage.dart';

class TheLoai extends StatefulWidget {
  @override
  _TheLoaiState createState() => _TheLoaiState();
}

class _TheLoaiState extends State<TheLoai> {
  TheLoaiController theLoaiController = Get.put(TheLoaiController());
  final TextEditingController tenController = TextEditingController();
  String? coverImagePath;

  @override
  void initState() {
    super.initState();
    // _getTheLoaiList();
  }

  // void _getTheLoaiList() {
  //   theLoaiController.getAllTheLoai();
  // }

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
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: theLoaiController.theLoaiData.length,
          itemBuilder: (context, index) {
            final theLoai = theLoaiController.theLoaiData[index];
            return GestureDetector(
              onTap: () {
                _navigateToTheLoaiDetailPage(theLoai);
              },
              child: Dismissible(
                key: Key(theLoai.ten.toString()),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await _confirmDeleteTheLoai(context, theLoai);
                },
                onDismissed: (direction) {
                  _deleteTheLoai(theLoai.ten!);
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
                            child: Image.network(
                              theLoai.coverImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              theLoai.ten!,
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
                  controller: theLoaiController.ten,
                  decoration: InputDecoration(labelText: 'Tên Thể Loại'),
                ),
                SizedBox(height: 20),
                
                InkWell(
                          onTap: () {
                            _selectCoverImage();
                          },
                          child: Obx(
                                () => Container(
                              height: 190,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Center(
                                child: theLoaiController.isCoverImageUploading.value
                                    ? CircularProgressIndicator(
                                  color: primaryColor,
                                )
                                    : theLoaiController.coverImageUrl.value == ""
                                    ? Image.asset("Assets/Icons/addImage.png")
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    theLoaiController.coverImageUrl.value,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
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
                // _addTheLoai(context);
                theLoaiController.createTheLoai();
                Navigator.of(context).pop();
              },
              child: Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _confirmDeleteTheLoai(BuildContext context, TheLoaiModel theLoai) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa thể loại này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Đóng hộp thoại xác nhận và trả về false (không xóa)
              },
              child: Text('Hủy', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Đóng hộp thoại xác nhận và trả về true (xóa)
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
    return result;
  }

void _deleteTheLoai(String ten) {
  // Xóa thể loại từ danh sách theLoaiData dựa trên tên
  theLoaiController.theLoaiData.removeWhere((theLoai) => theLoai.ten == ten);
  // Cập nhật lại danh sách thể loại trên Firestore nếu cần
  theLoaiController.deleteTheLoaiByName(ten);
}

  void _selectCoverImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        theLoaiController.pickCoverImage(); 
    }
  }


  void _navigateToTheLoaiDetailPage(TheLoaiModel theLoai) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TheLoaiDetailPage(theLoai: theLoai),
      ),
    );
  }
}
