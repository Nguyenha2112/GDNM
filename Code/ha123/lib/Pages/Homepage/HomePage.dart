import 'package:meapsbook/Components/BookCard.dart';
import 'package:meapsbook/Components/BookCardON.dart';
import 'package:meapsbook/Components/BookTile.dart';
import 'package:meapsbook/Components/BookTileON.dart';
import 'package:meapsbook/Components/MyDrawer.dart';
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
                    child: Row(
                      children: [
                        BookCardOn(
                          title: "Nếu tôi biết khi còn 20",
                          coverUrl: "Assets/Images/neutoibietduockhicon20.jpg",
                          ontap: () {
                            Get.to(BookDetails());


                          },
                        ),
                        BookCardOn(
                          title: "Công nghệ BlockChain",
                          coverUrl: "Assets/Images/congngheblockchain.jpg",
                          ontap: () {
                            Get.to(BookDetails());

                          },
                        ),
                        BookCardOn(
                          title: "Tây du ký",
                          coverUrl:'Assets/Images/tayduki.jpg',
                          ontap: () {
                            Get.to(BookDetails());

                          },
                        ),
                        // Thêm các sách khác nếu cần
                      ],
                    ),
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
                    child: Row(
                      children: [
                        BookCardOn(
                          title: "Nếu tôi biết khi còn 20",
                          coverUrl: "Assets/Images/neutoibietduockhicon20.jpg",
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Tây du ký",
                          coverUrl:'Assets/Images/tayduki.jpg',
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Công nghệ BlockChain",
                          coverUrl: "Assets/Images/congngheblockchain.jpg",
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Tây du ký",
                          coverUrl:'Assets/Images/tayduki.jpg',
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Công nghệ BlockChain",
                          coverUrl: "Assets/Images/congngheblockchain.jpg",
                          ontap: () {

                          },
                        ),
                        // Thêm các sách khác nếu cần
                      ],
                    ),
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
                    child: Row(
                      children: [
                        BookCardOn(
                          title: "Tên sách 1",
                          coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Tên sách 2",
                          coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Tên sách 2",
                          coverUrl:'Assets/Images/tayduki.jpg',
                          ontap: () {

                          },
                        ),
                        // Thêm các sách khác nếu cần
                      ],
                    ),
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
                    child: Row(
                      children: [
                        BookCardOn(
                          title: "Tên sách 1",
                          coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                          ontap: () {

                          },
                        ),
                        BookCardOn(
                          title: "Tên sách 2",
                          coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                          ontap: () {

                          },
                        ),
                        // Thêm các sách khác nếu cần
                      ],
                    ),
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
                Row(
                    children: [
                      BookCardOn(
                        title: "Tên sách 1",
                        coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                        ontap: () {

                        },
                      ),
                      BookCardOn(
                        title: "Tên sách 2",
                        coverUrl:'Assets/Images/tayduki.jpg',
                        ontap: () {

                        },
                      ),
                      BookCardOn(
                        title: "Tên sách 2",
                        coverUrl:'Assets/Images/tayduki.jpg',
                        ontap: () {

                        },
                      ),
                      // Thêm các sách khác nếu cần
                    ],
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
                 Row(
                    children: [
                      BookCardOn(
                        title: "Tên sách 1",
                        coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                        ontap: () {

                        },
                      ),
                      BookCardOn(
                        title: "Tên sách 2",
                        coverUrl: "Assets/Images/tacgia/ToHoai.jpg",
                        ontap: () {

                        },
                      ),
                      // Thêm các sách khác nếu cần
                    ],
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
