import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meapsbook/Config/Messages.dart';
import 'package:meapsbook/Models/TheLoaiModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class TheLoaiController extends GetxController {
  TextEditingController ten = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  RxString coverImageUrl = "".obs;
  RxBool isCoverImageUploading = false.obs;
  RxBool isPostUploading = true.obs;
  var theLoaiData = RxList<TheLoaiModel>();
  RxList<String> categoryNames = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllTheLoai();
  }

  void getAllTheLoai() async {
    theLoaiData.clear();
    var theLoais = await db.collection("TheLoais").get();
    for (var theLoai in theLoais.docs) {
      theLoaiData.add(TheLoaiModel.fromJson(theLoai.data()));
    }
  }



  void pickCoverImage() async {
    isCoverImageUploading.value = true;
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      uploadCoverImageToFirebase(File(image.path));
    }
    isCoverImageUploading.value = false;
  }

  

void deleteTheLoaiByName(String ten) async {
  try {
    await db.collection("TheLoais").where("ten", isEqualTo: ten).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  } catch (e) {
    print("Lỗi khi xóa thể loại: $e");
  }
}

Future<List<String>> getCategoryFromFirebase() async {
  try {
    var authors = await db.collection("TheLoais").get();
    var names = authors.docs.map((doc) => doc["ten"] as String).toList();
    categoryNames.value = names;
    return names;
  } catch (e) {
    print("Lỗi khi lấy danh sách tên tác giả từ Firebase: $e");
    throw e; // Ném lỗi để FutureBuilder xử lý
  }
}


  void uploadCoverImageToFirebase(File image) async {
    var uuid = Uuid();
    var filename = uuid.v1();
    var storageRef = storage.ref().child("CoverImages/$filename");
    var response = await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    coverImageUrl.value = downloadURL;
    print("Download URL: $downloadURL");
    isCoverImageUploading.value = false;
  }

  void createTheLoai() async {
    isPostUploading.value = true;
    var newTheLoai = TheLoaiModel(
      ten: ten.text,
      coverImage: coverImageUrl.value,
    );

    await db.collection("TheLoais").add(newTheLoai.toJson());
    isPostUploading.value = false;
    ten.clear();
    coverImageUrl.value = "";
    successMessage("Thể loại đã được thêm vào cơ sở dữ liệu");
    getAllTheLoai();
  }
}
