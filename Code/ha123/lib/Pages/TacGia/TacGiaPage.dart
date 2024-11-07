
import 'package:get/get_core/src/get_main.dart';
import 'package:meapsbook/Components/BookTile.dart';
import 'package:meapsbook/Components/BookTileON.dart';
import 'package:meapsbook/Config/Colors.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.authorName),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Obx(() =>  Column(

      )
      ),

    );
  }
}
