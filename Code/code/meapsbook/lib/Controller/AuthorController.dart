import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapsbook/Config/Messages.dart';
import 'package:meapsbook/Models/AuthorModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AuthorController extends GetxController {
  TextEditingController hovaten = TextEditingController();
  TextEditingController namsinh = TextEditingController();
  TextEditingController quequan = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  RxString coverImageUrl = "".obs;
  RxBool isCoverImageUploading = false.obs;
  RxBool isPostUploading = true.obs;
  var authorData = RxList<AuthorModel>();
  RxList<String> authorNames = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllAuthors();

  }

  void getAllAuthors() async {
    authorData.clear();
    var authors = await db.collection("Authors").get();
    for (var author in authors.docs) {
      authorData.add(AuthorModel.fromJson(author.data()));
    }
  }


 Future<List<String>> getAuthorNamesFromFirebase() async {
  try {
    var authors = await db.collection("Authors").get();
    var names = authors.docs.map((doc) => doc["hovaten"] as String).toList();
    authorNames.value = names;
    return names;
  } catch (e) {
    print("Lỗi khi lấy danh sách tên tác giả từ Firebase: $e");
    throw e; // Ném lỗi để FutureBuilder xử lý
  }
}

  void pickAuthorImage() async {
    isCoverImageUploading.value = true;
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      uploadCoverImageToFirebase(File(image.path));
    }
    isCoverImageUploading.value = false;
  }

  void deleteAuthor(String hovaten) {
    authorData.removeWhere((author) => author.hovaten == hovaten);
  }

  void deleteAuthorByName(String hovaten) async {
    try {
      await db.collection("Authors").where("hovaten", isEqualTo: hovaten).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } catch (e) {
      print("Lỗi khi xóa tác giả: $e");
    }
  }
  void updateAuthorByName(String hovaten, Map<String, dynamic> newData) async {
    try {
      await db.collection("Authors").where("hovaten", isEqualTo: hovaten).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.update(newData);
         
        }); getAllAuthors();
      });
    } catch (e) {
      print("Lỗi khi cập nhật tác giả: $e");
    }
  }


  void uploadCoverImageToFirebase(File image) async {
    var uuid = Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("AuthorImages/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    coverImageUrl.value = downloadURL;
    print("Download URL: $downloadURL");
    isCoverImageUploading.value = false;
  }


  void createAuthor() async {
    isPostUploading.value = true;
    var newAuthor = AuthorModel(
      hovaten: hovaten.text,
      namsinh: namsinh.text,
      quequan: quequan.text,
      coverImage: coverImageUrl.value,
    );

    await db.collection("Authors").add(newAuthor.toJson());
    isPostUploading.value = false;
    hovaten.clear();
    namsinh.clear();
    quequan.clear();
    coverImageUrl.value = "";
    successMessage("Tác giả đã được thêm vào cơ sở dữ liệu");
    getAllAuthors();
  }
}
