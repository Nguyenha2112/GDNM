// import 'package:meapsbook/Models/AuthorModel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// import '../Models/TheLoaiModel.dart';


// class DatabaseHelper {
//   static DatabaseHelper? _instance;
//   static Database? _database;

//   DatabaseHelper._internal();

//   factory DatabaseHelper() {
//     if (_instance == null) {
//       _instance = DatabaseHelper._internal();
//     }
//     return _instance!;
//   }

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await initDatabase();
//     return _database!;
//   }

//   Future<Database> initDatabase() async {
//     String databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'my_database.db');


//     return await openDatabase(path, version: 1, onCreate: (db, version) async {
//       // await db.execute('''
//       //     CREATE TABLE TheLoai(
//       //       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       //       ten TEXT,
//       //       coverImage TEXT
//       //     )
//       //   ''');
//       await db.execute('''
//       CREATE TABLE TacGia(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         hovaten TEXT,
//         namsinh TEXT,
//         quequan TEXT,
//         coverImage TEXT
//       )
//     ''');

//       // Thêm các dòng dữ liệu thể loại khác tại đây

//       // await db.insert('TheLoai', {'ten': 'TÌNH CẢM', 'coverImage': 'Assets/Images/langman.jpg'});
//       // await db.insert('TheLoai', {'ten': 'LỊCH SỬ', 'coverImage': 'Assets/Images/lichsu.jpg'});
//       // await db.insert('TheLoai', {'ten': 'NƯỚC NGOÀI', 'coverImage': 'Assets/Images/nuocngoai.jpeg'});
//       // await db.insert('TheLoai', {'ten': 'TRINH THÁM', 'coverImage': 'Assets/Images/trinhtham.jpg'});
//       // await db.insert('TheLoai', {'ten': 'KINH DỊ', 'coverImage': 'Assets/Images/kinhdi.jpg'});
//       // await db.insert('TheLoai', {'ten': 'KHOA HỌC', 'coverImage': 'Assets/Images/khoahoc.jpg'});
//       // await db.insert('TheLoai', {'ten': 'KINH TẾ', 'coverImage': 'Assets/Images/kinhte.jpeg'});
//       // await db.insert('TheLoai', {'ten': 'NGỤ NGÔN', 'coverImage': 'Assets/Images/ngungon2.jpg'});
//       // await db.insert('TheLoai', {'ten': 'HÀI HƯỚC', 'coverImage': 'Assets/Images/langman.jpg'});
//       // await db.insert('TheLoai', {'ten': 'PHIÊU LƯU', 'coverImage': 'Assets/Images/phieuluu2.webp'});
//       // await db.insert('TheLoai', {'ten': 'TÀI CHÍNH', 'coverImage': 'Assets/Images/taichinh2.jpg'});
//       // await db.insert('TheLoai', {'ten': 'TIỂU THUYẾT', 'coverImage': 'Assets/Images/nuocngoai.jpeg'});

//       // Thêm các dòng dữ liệu tác giả khác tại đây

//       await db.insert('TacGia', {'hovaten': 'Ngô Thừa Ân', 'namsinh':'1920-2014', 'quequan':'Hà Nội', 'coverImage': 'Assets/Images/tacgia/ToHoai.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Đoàn Giỏi', 'namsinh': '1925-1989', 'quequan': 'Hồ Chí Minh', 'coverImage': 'Assets/Images/tacgia/DoanGioi.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Trần Đăng Khoa','namsinh':'1958','quequan':'Hải Dương', 'coverImage': 'Assets/Images/tacgia/TranDangKhoa.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Võ Quảng','namsinh':'1920-2007','quequan':'Hà Nội', 'coverImage': 'Assets/Images/tacgia/VoQuang.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Sơn Tùng','namsinh':'1928-2021','quequan':'Hồ Chí Minh', 'coverImage': 'Assets/Images/tacgia/SonTung.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Nguyễn Nhật Ánh','namsinh':'1955','quequan':'Hà Nội', 'coverImage': 'Assets/Images/tacgia/NguyenNhatAnh.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Hemingway','namsinh':'1899 - 1961','quequan':'Mỹ', 'coverImage': 'Assets/Images/tacgia/Hemingway.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Franz Kafka','namsinh':'1883-1924','quequan':'Đức', 'coverImage': 'Assets/Images/tacgia/FranzKafka.jpg'});
//       await db.insert('TacGia', {'hovaten': 'J.R.R.Tolkien','namsinh':'1892-1973','quequan':'Anh', 'coverImage': 'Assets/Images/tacgia/J.R.R.Tolkien.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Garcia Marquez','namsinh':'1927-2014','quequan':'Colombia', 'coverImage': 'Assets/Images/tacgia/GabrielGarciaMarquez.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Harper Lee','namsinh':'1926-2016','quequan':'Mỹ', 'coverImage': 'Assets/Images/tacgia/HarperLee.jpg'});
//       await db.insert('TacGia', {'hovaten': 'Shakespeare','namsinh':'1564-1616','quequan':'Anh', 'coverImage': 'Assets/Images/tacgia/WilliamShakespeare.jpg'});
//       // Thêm các dòng dữ liệu khác tại đây
//     });
//   }



 

//   Future<int> deleteTheLoai(int id) async {
//     Database db = await database;
//     return await db.delete('TheLoai', where: 'id = ?', whereArgs: [id]);
//   }

//   // Future<int> addTacGia(AuthorModel tacGia) async {
//   //   Database db = await database;
//   //   return await db.insert('TacGia', tacGia.toMap()); // Sửa dòng này
//   // }

//   Future<int> deleteTacGia(String hovaten) async {
//     Database db = await database;
//     return await db.delete('TacGia', where: 'hovaten = ?', whereArgs: [hovaten]);
//   }


//   // Future<List<AuthorModel>> getAllTacGia() async {
//   //   Database db = await database;
//   //   List<Map<String, dynamic>> tacGiaMapList = await db.query('TacGia');
//   //   return List.generate(tacGiaMapList.length, (index) {
//   //     return AuthorModel.fromMap(tacGiaMapList[index]);
//   //   });
//   // }
//   Future<List<String>> getCategoryNames() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('TheLoai');

//     // Convert maps to List<String>
//     return List.generate(maps.length, (i) {
//       return maps[i]['ten']; // Sửa 'name' thành 'ten'
//     });
//   }
//   Future<List<String>> getAuthorNames() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('TacGia');

//     // Convert maps to List<String>
//     return List.generate(maps.length, (i) {
//       return maps[i]['hovaten']; // Sửa 'name' thành 'ten'
//     });
//   }
// }
