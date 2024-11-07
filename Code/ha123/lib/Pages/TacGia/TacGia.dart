import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapsbook/Config/Colors.dart';

class TacGia extends StatefulWidget {
  @override
  _TacGiaState createState() => _TacGiaState();
}

class _TacGiaState extends State<TacGia> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

                      itemBuilder: (context, index) {
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 10.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Họ và tên: "
                                                  "Năm sinh: "
                                                  "Quê quán: ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundColor:
                                              Theme
                                                  .of(context)
                                                  .colorScheme
                                                  .background,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                child: InkWell(
                                                  onTap: () {

                                                  },

                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(thickness: 1, height: 20),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {

                                            },
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF4F6FA),
                                                borderRadius: BorderRadius
                                                    .circular(10),
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
                                            onTap: () {},
                                            child: Container(
                                              width: 150,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius
                                                    .circular(10),
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

                decoration: InputDecoration(labelText: "Họ và Tên"),
              ),
              TextField(

                decoration: InputDecoration(labelText: "Năm Sinh"),
              ),
              TextField(

                decoration: InputDecoration(labelText: "Quê Quán"),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _selectAuthorImage();
                },

              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
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

    }
  }

  void _confirmDeleteAuthor(author) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa tác giả này không?'),
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
  }


}


