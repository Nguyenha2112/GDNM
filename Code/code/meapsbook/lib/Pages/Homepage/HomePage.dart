import 'package:meapsbook/Components/BookCard.dart';
import 'package:meapsbook/Components/BookCardON.dart';
import 'package:meapsbook/Components/BookTile.dart';
import 'package:meapsbook/Components/BookTileON.dart';
import 'package:meapsbook/Components/MyDrawer.dart';
import 'package:meapsbook/Controller/BookController.dart';
import 'package:meapsbook/Models/BookModel.dart';
import 'package:meapsbook/Models/Data.dart';
import 'package:meapsbook/Pages/BookDetails/BookDetails.dart';
import 'package:meapsbook/Pages/Homepage/Widgets/AppBar.dart';
import 'package:meapsbook/Pages/Homepage/Widgets/CategoryWidget.dart';
import 'package:meapsbook/Pages/Homepage/Widgets/MyInputeTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BookController bookController = Get.put(BookController());
    bookController.getUserBook();
    return Scaffold(
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              // height: 500,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          HomeAppBar(),
                          SizedBox(height: 30),                                            
                          MyInputTextField(),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Topics",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categoryData
                                  .map(
                                    (e) => CategoryWidget(
                                        iconPath: e["icon"]!,
                                        btnName: e["lebel"]!),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [

                      Text(
                        "TẤT CẢ SÁCH",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() =>  Row(
                        children: bookController.bookData
                            .map(
                              (e) => BookCardOn(
                            title: e.title!,
                            coverUrl: e.coverUrl!,
                            ontap: () {
                              Get.to(BookDetails(
                                book: e,
                              ));
                            },
                          ),
                        )
                            .toList(),
                      ),)
                  ),
                 

                    //thể loại 1 bắt đầu
                  SizedBox(height: 10),
                  Row(
                    children: [

                      Text(
                        "NƯỚC NGOÀI",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() =>  Row(
                          children: bookController.bookData.where((book) => book.category == "NƯỚC NGOÀI")
                              .map(
                                (e) => BookCardOn(
                                  title: e.title!,
                                  coverUrl: e.coverUrl!,
                                  ontap: () {
                                    Get.to(BookDetails(
                                      book: e,
                                    ));
                                  },
                                ),
                              )
                              .toList(),
                        ),)
                      ),

                      // thể loại 1 kết thúc
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "TRINH THÁM",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() =>  Row(
                        children: bookController.bookData.where((book) => book.category == "TRINH THÁM")
                            .map(
                              (e) => BookCardOn(
                            title: e.title!,
                            coverUrl: e.coverUrl!,
                            ontap: () {
                              Get.to(BookDetails(
                                book: e,
                              ));
                            },
                          ),
                        )
                            .toList(),
                      ),)
                  ),

                  // thể loại 1 kết thúc
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "TIỂU THUYẾT",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() =>  Row(
                        children: bookController.bookData.where((book) => book.category == "TIỂU THUYẾT")
                            .map(
                              (e) => BookCardOn(
                            title: e.title!,
                            coverUrl: e.coverUrl!,
                            ontap: () {
                              Get.to(BookDetails(
                                book: e,
                              ));
                            },
                          ),
                        )
                            .toList(),
                      ),)
                  ),

                  // thể loại 1 kết thúc
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "TÌNH CẢM",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(() =>  Column(
                    children: bookController.bookData.where((book) => book.category == "TÌNH CẢM")
                        .map(
                          (e) => BookTileOn(
                        ontap: () {
                          Get.to(BookDetails(book: e));
                        },
                        title: e.title!,
                        coverUrl: e.coverUrl!,
                        author: e.author!,
                        price: e.price!,
                        rating: e.rating!,
                        totalRating: e.rating!,
                      ),
                    )
                        .toList(),
                  )
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "LỊCH SỬ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(() =>  Column(
                        children: bookController.bookData.where((book) => book.category == "LỊCH SỬ")
                            .map(
                              (e) => BookTileOn(
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
                  

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
