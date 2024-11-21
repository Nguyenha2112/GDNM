import 'package:flutter/foundation.dart';
import 'package:meapsbook/Components/BackButton.dart';
import 'package:meapsbook/Components/MutiLineTextFormField.dart';
import 'package:meapsbook/Components/MyTextFormField.dart';
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Controller/AuthorController.dart';
import 'package:meapsbook/Controller/BookController.dart';
import 'package:meapsbook/Controller/PdfController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meapsbook/Controller/TheLoaiController.dart';
import 'package:meapsbook/Data/DatabaseHelper.dart';


class AddNewBookPage extends StatelessWidget {
  AddNewBookPage({Key? key});
  final Color customColor = Color(0xFFD9E1DC); // Mã màu D9E1DC

// Tạo hàm để lấy danh sách tên từ DataHelper
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    PdfController pdfController = Get.put(PdfController());
    BookController bookController = Get.put(BookController());
    AuthorController authorController = Get.put(AuthorController());
    TheLoaiController theLoaiController = Get.put(TheLoaiController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                              "ADD NEW BOOK",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            SizedBox(width: 70)
                          ],
                        ),
                        SizedBox(height: 60),
                        InkWell(
                          onTap: () {
                            bookController.pickImage();
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
                                child: bookController.isImageUploading.value
                                    ? CircularProgressIndicator(
                                  color: primaryColor,
                                )
                                    : bookController.imageUrl.value == ""
                                    ? Image.asset("Assets/Icons/addImage.png")
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    bookController.imageUrl.value,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                              () => Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: bookController.pdfUrl.value == ""
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: bookController.isPdfUploading.value
                                ? Center(
                              child: CircularProgressIndicator(
                                color: backgroudColor,
                              ),
                            )
                                : bookController.pdfUrl.value == ""
                                ? InkWell(
                              onTap: () {
                                bookController.pickPDF();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("Assets/Icons/upload.png"),
                                  SizedBox(width: 8),
                                  Text(
                                    "Book PDF",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.background,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : InkWell(
                              onTap: () {
                                bookController.pdfUrl.value = "";
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "Assets/Icons/delete.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Delete Pdf",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Book title",
                    icon: Icons.book,
                    controller: bookController.title,
                  ),
                  SizedBox(height: 10),
                  MultiLineTextField(
                    hintText: "Book Description",
                    controller: bookController.des,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FutureBuilder<void>(
                      future: authorController.getAuthorNamesFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return Obx(() {
                            final authorNames = authorController.authorNames;
                            if (authorNames.isNotEmpty) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: customColor,
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'AuthorName',
                                    labelStyle: TextStyle(color: lebelColor),
                                    icon: Icon(Icons.person, color: primaryColor),
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: customColor,
                                  value: authorNames[0],
                                  items: authorNames.map((authorName) {
                                    return DropdownMenuItem<String>(
                                      value: authorName,
                                      child: Text(authorName, style: TextStyle(color: lebelColor)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    return bookController.updateAuthor(newValue!);
                                  },
                                ),
                              );
                            } else {
                              return Text("No data available");
                            }
                          });
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  //bat dau
                  Container(
                    decoration: BoxDecoration(
                      color: customColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FutureBuilder<void>(
                      future: theLoaiController.getCategoryFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          return Obx(() {
                            final categoryNames = theLoaiController.categoryNames;
                            if (categoryNames.isNotEmpty) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: customColor,
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Category',
                                    labelStyle: TextStyle(color: lebelColor),
                                    icon: Icon(Icons.person, color: primaryColor),
                                    border: InputBorder.none,
                                  ),
                                  dropdownColor: customColor,
                                  value: categoryNames[0],
                                  items: categoryNames.map((authorName) {
                                    return DropdownMenuItem<String>(
                                      value: authorName,
                                      child: Text(authorName, style: TextStyle(color: lebelColor)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    return bookController.updateCatelogy(newValue!);
                                  },
                                ),
                              );
                            } else {
                              return Text("No data available");
                            }
                          });
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Price",
                    isNumber: true,
                    icon: Icons.currency_rupee,
                    controller: bookController.price,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Pages",
                    isNumber: true,
                    icon: Icons.book,
                    controller: bookController.pages,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Language",
                    icon: Icons.language,
                    controller: bookController.language,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Rating",
                    icon: Icons.eighteen_up_rating,
                    controller: bookController.rating,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.red,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "CANCEL",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Obx(
                              () => Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: bookController.isPdfUploading.value
                                ? Center(
                              child: CircularProgressIndicator(),
                            )
                                : InkWell(
                              onTap: () {
                                bookController.createBook();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_sharp,
                                    color: Theme.of(context).colorScheme.background,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "POST",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.background,
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
