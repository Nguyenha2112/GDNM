import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meapsbook/Components/BookTile.dart';
import 'package:meapsbook/Components/BookTileON.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Controller/BookController.dart';
import 'package:meapsbook/Data/DatabaseHelper.dart';
import 'package:meapsbook/Models/BookModel.dart';
import 'package:meapsbook/Models/Data.dart';
import 'package:meapsbook/Models/TheLoaiModel.dart';
import 'package:meapsbook/Pages/BookDetails/BookDetails.dart';

class TheLoaiDetailPage extends StatefulWidget {
  final TheLoaiModel theLoai;

  const TheLoaiDetailPage({required this.theLoai});

  @override
  _TheLoaiDetailPageState createState() => _TheLoaiDetailPageState();
}

class _TheLoaiDetailPageState extends State<TheLoaiDetailPage> {
  // DatabaseHelper databaseHelper = DatabaseHelper();
  List<BookModel> sachList = [];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Các sách có thể loại ${widget.theLoai.ten}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Obx(() => 
      Column(
        children: bookController.bookData.where((book) => book.category == widget.theLoai.ten)
            .map(
              (e) =>
              BookTileOn(
                ontap: () {
                  Get.to(BookDetails(book: e));
                },
                title: e.title!,
                coverUrl: e.coverUrl!,
                author: e.author!,
                price: e.price!,
                rating: e.rating!,
                totalRating: "",
              ),
        )
            .toList(),
      )
      ),
    );
  }
}
