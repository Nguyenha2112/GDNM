
import 'package:get/get_core/src/get_main.dart';
import 'package:meapsbook/Components/BookTile.dart';
import 'package:meapsbook/Components/BookTileON.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Controller/BookController.dart';
import 'package:meapsbook/Models/AuthorModel.dart';
import 'package:meapsbook/Models/BookModel.dart';
import 'package:meapsbook/Models/Data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meapsbook/Pages/BookDetails/BookDetails.dart';

class TacGiaPage extends StatefulWidget {
  final AuthorModel TacGia;
  final String authorName;

  const TacGiaPage({Key? key, required this.authorName, required this.TacGia}) : super(key: key);

  @override
  _TacGiaPageState createState() => _TacGiaPageState();
}

class _TacGiaPageState extends State<TacGiaPage> {
  late List<BookModel> bookList;

  @override
  void initState() {
    super.initState();
    bookList = [];
  }

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.authorName),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Obx(() =>  Column(
        children: bookController.bookData.where((book) => book.author == widget.TacGia.hovaten)
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
