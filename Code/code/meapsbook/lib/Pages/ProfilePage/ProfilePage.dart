import 'package:meapsbook/Components/BackButton.dart';
import 'package:meapsbook/Components/BookTileON.dart';
import 'package:meapsbook/Controller/AuthController.dart';
import 'package:meapsbook/Controller/BookController.dart';
import 'package:meapsbook/Models/Data.dart';
import 'package:meapsbook/Pages/AddNewBook/AddNewBook.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meapsbook/Pages/BookDetails/BookDetails.dart';

import '../../Models/BookModel.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}
  class _ProfilePage extends State<ProfilePage> {
  AuthController authController = Get.put(AuthController());
  BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNewBookPage());
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 500,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyBackButton(),
                          Text(
                            "Profile",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          IconButton(
                              onPressed: () {
                                authController.signout();
                              },
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Theme.of(context).colorScheme.background,
                              ))
                        ],
                      ),
                      SizedBox(height: 60),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.background,
                            )),
                        child: Container(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "Assets/Icons/account.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${authController.auth.currentUser!.displayName}" ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.background),
                      ),
                      Text(
                        "${authController.auth.currentUser!.email}",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text("Your Books",
                    style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            SizedBox(height: 20),
            Obx(
                  () => Column(
                children: bookController.currentUserBooks
                    .map((e) {
                  final book = e;
                  return GestureDetector(
                    onHorizontalDragUpdate: (details) {},
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await _confirmDeleteBook(context, book);
                      },
                      onDismissed: (direction) {
                        _deleteBook(e.title!);
                      },
                      // Không cần gọi hàm xóa trực tiếp ở đây
                      child: BookTileOn(
                        title: e.title!,
                        coverUrl: e.coverUrl!,
                        author: e.author!,
                        price: e.price!,
                        rating: e.rating!,
                        totalRating: "",
                        ontap: () {
                          Get.to(BookDetails(book: e));
                        },
                      ),
                    ),
                  );
                })
                    .toList(),
              ),
            )
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }
  Future<bool> _confirmDeleteBook(BuildContext context, BookModel book) async {
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
  void _deleteBook(String name) {
    try {
      // Xóa cuốn sách khỏi danh sách currentUserBooks
      bookController.currentUserBooks.removeWhere((book) => book.title == name);
      // Gọi hàm deleteBookByName để xóa cuốn sách khỏi Firestore
      bookController.deleteBookByName(name);
    } catch (e) {
      print("Error deleting book: $e");
    }
  }
}
