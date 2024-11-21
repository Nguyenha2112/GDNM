import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Controller/AuthorController.dart';
import 'package:meapsbook/Models/AuthorModel.dart';
import 'package:meapsbook/Pages/TacGia/TacGiaPage.dart';

class TacGia extends StatefulWidget {
  @override
  _TacGiaState createState() => _TacGiaState();
}

class _TacGiaState extends State<TacGia> {
  final authorController = Get.put(AuthorController());
  List<AuthorModel> tacGiaFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    // authorController.getAllAuthors();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Danh sách Tác Giả',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(67, 104, 80, 1.0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterAuthors(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  hintText: 'Tìm kiếm',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                    () =>
                    ListView.builder(
                      itemCount: authorController.authorData.length,
                      itemBuilder: (context, index) {
                        final tacGia = authorController.authorData[index];
                        return Card(
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 20.0,
                                          left: 20.0,
                                          top: 10.0,
                                          bottom: 10.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Họ và tên: ${tacGia.hovaten}\n"
                                                  "Năm sinh: ${tacGia
                                                  .namsinh!}\n"
                                                  "Quê quán: ${tacGia
                                                  .quequan!}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                            ),
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundColor: Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .background,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(30),
                                                child: InkWell(
                                                  onTap: () {
                                                    _showTacGiaPage(tacGia);
                                                  },
                                                  child: Image.network(
                                                    tacGia.coverImage!,
                                                    fit: BoxFit.cover,
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Divider(
                                          thickness: 1,
                                          height: 20,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _editAuthor(tacGia);
                                            },
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF4F6FA),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Chỉnh sửa",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _confirmDeleteAuthor(tacGia);
                                            },
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Xóa",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogAddAuthor(context);
        },
        child: Icon(
          Icons.add,
          color: Theme
              .of(context)
              .colorScheme
              .background,
        ),
      ),
    );
  }

  void _filterAuthors(String keyword) {
    setState(() {
      tacGiaFiltered = authorController.authorData
          .where((author) =>
      author.hovaten!
          .toLowerCase()
          .contains(keyword.toLowerCase()) ||
          author.quequan!
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    });
  }

  void _showDialogAddAuthor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thêm Tác Giả"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: authorController.hovaten,
                decoration: InputDecoration(labelText: "Họ và Tên"),
              ),
              TextField(
                controller: authorController.namsinh,
                decoration: InputDecoration(labelText: "Năm Sinh"),
              ),
              TextField(
                controller: authorController.quequan,
                decoration: InputDecoration(labelText: "Quê Quán"),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _selectAuthorImage();
                },
                child: Obx(
                      () =>
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Center(
                          child: authorController.isCoverImageUploading.value
                              ? CircularProgressIndicator(
                            color: primaryColor,
                          )
                              : authorController.coverImageUrl.value == ""
                              ? Image.asset("Assets/Icons/addImage.png")
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              authorController.coverImageUrl.value,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                authorController.createAuthor();
                Navigator.of(context).pop();
              },
              child: Text("Thêm"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Hủy"),
            ),
          ],
        );
      },
    );
  }

  void _selectAuthorImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      authorController.pickAuthorImage();
    }
  }

  void _showTacGiaPage(AuthorModel author) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TacGiaPage(authorName: author.hovaten!, TacGia: author,),
      ),
    );
  }

  void _confirmDeleteAuthor(AuthorModel author) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa tác giả này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Đóng hộp thoại xác nhận và trả về false (không xóa)
              },
              child: Text('Hủy', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                _deleteAuthor(author.hovaten!);
                Navigator.of(context).pop(
                    true); // Đóng hộp thoại xác nhận và trả về true (xóa)
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteAuthor(String ten) {
    authorController.authorData.removeWhere((author) => author.hovaten == ten);
    authorController.deleteAuthorByName(ten);
  }

  void _editAuthor(AuthorModel author) {
    TextEditingController _hovatenController = TextEditingController(
        text: author.hovaten);
    TextEditingController _namsinhController = TextEditingController(
        text: author.namsinh);
    TextEditingController _quequanController = TextEditingController(
        text: author.quequan);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Chỉnh sửa Tác Giả"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _hovatenController,
                decoration: InputDecoration(labelText: "Họ và Tên"),
              ),
              TextField(
                controller: _namsinhController,
                decoration: InputDecoration(labelText: "Năm Sinh"),
              ),
              TextField(
                controller: _quequanController,
                decoration: InputDecoration(labelText: "Quê Quán"),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _selectAuthorImage();
                },
                child: Obx(
                      () =>
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .background,
                        ),
                        child: Center(
                          child: authorController.isCoverImageUploading.value
                              ? CircularProgressIndicator(
                            color: primaryColor,
                          )
                              : authorController.coverImageUrl.value == ""
                              ? Image.asset("Assets/Icons/addImage.png")
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              authorController.coverImageUrl.value,
                              fit: BoxFit.cover,
                            ),
                          ), 
                        ),
                      ),
                ),
              ),
            ],
          ),
          actions: [
            
            ElevatedButton(
              onPressed: () async {
                // Cập nhật thông tin tác giả
                
                Map<String, dynamic> newData = {
                  'hovaten': _hovatenController.text,
                  'namsinh': _namsinhController.text,
                  'quequan': _quequanController.text,
                };authorController.getAllAuthors();
                authorController.updateAuthorByName(author.hovaten!, newData);
                Navigator.of(context).pop();
               
                // Không cần setState() ở đây vì dialog sẽ tự đóng và widget tree sẽ rebuild khi dialog đóng
              },
              child: Text("Lưu"),
            ),
            ElevatedButton(
              onPressed: (
                
                
              ) {
                Navigator.of(context).pop();
                // Không cần setState() ở đây vì dialog sẽ tự đóng và widget tree sẽ rebuild khi dialog đóng
              },
              child: Text("Hủy"),
            ),
          ],
          
        );
      },
    );
  }
}