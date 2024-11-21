// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meapsbook/Models/TheLoaiModel.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addTheLoai(TheLoaiModel theLoai) async {
//     try {
//       await _firestore.collection('the_loai').add(theLoai.toMap());
//     } catch (e) {
//       print('Error adding theLoai: $e');
//     }
//   }

//   Future<List<TheLoaiModel>> getTheLoaiList() async {
//     List<TheLoaiModel> theLoaiList = [];
//     try {
//       QuerySnapshot querySnapshot = await _firestore.collection('the_loai').get();
//       querySnapshot.docs.forEach((doc) {
//         theLoaiList.add(TheLoaiModel.fromMap(doc.data() as Map<String, dynamic>));
//       });
//     } catch (e) {
//       print('Error getting theLoai list: $e');
//     }
//     return theLoaiList;
//   }
// }
