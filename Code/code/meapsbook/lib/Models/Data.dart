import 'package:meapsbook/Models/AuthorModel.dart';
import 'package:meapsbook/Models/BookModel.dart';
import 'package:meapsbook/Models/TheLoaiModel.dart';

var categoryData = [
  {
    "icon": "Assets/Icons/heart.svg",
    "lebel": "Romance",
  },
  {
    "icon": "Assets/Icons/plane.svg",
    "lebel": "Travel",
  },
  {
    "icon": "Assets/Icons/world.svg",
    "lebel": "Documentary",
  },
  {
    "icon": "Assets/Icons/heart.svg",
    "lebel": "Love Story",
  },
];

var bookData = [
  BookModel(
      id: "1",
      title:
          "Tây Du Kí ",
      description:
          "Tây Du Ký là bộ tiểu thuyết thần thoại của lịch sử cổ đại Trung Quốc. Truyện mang tính chất hư cấu kể về bốn thầy trò Đường Tăng trên con đường trắc trở đi thỉnh kinh.",
      aboutAuthor: "hi my name is Nitish Roy and i have written this book",
      audioLen: "20",
      author: "Ngô Thừa Ân",
      coverUrl: "Assets/Images/tayduki.jpg",
      rating: "4.2",
      category: "Tiểu thuyết",
      numberofRating: "10,",
      price: 100,
      pages: 234,
      language: "VN",
      bookurl:
          "Assets/Bookss/tayduki.pdf"),
  BookModel(
      id: "2",
      title: "Thao túng tâm lý",
      description:
          "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum",
      aboutAuthor: "hi my name is Nitish Roy and i have written this book",
      audioLen: "20",
      author: "SHANNON THOMAS,LCSW",
      coverUrl: "Assets/Images/thaotungtamli.jpg",
      rating: "4.2",
      category: "Documentary",
      price: 100,
      numberofRating: "10,",
      language: "ENG",
      pages: 234,
      bookurl:
          "Assets/Bookss/thaotungtamly.pdf"),
  BookModel(
      id: "3",
      title: "Công nghệ BlockChain",
      description:
          "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum",
      aboutAuthor: "hi my name is Nitish Roy and i have written this book",
      audioLen: "20",
      author: "Nitish Roy",
      coverUrl: "Assets/Images/congngheblockchain.jpg",
      rating: "4.2",
      category: "Documentary",
      numberofRating: "10,",
      price: 100,
      language: "ENG",
      pages: 234,
      bookurl:
          "Assets/Bookss/congngheblockchain.pdf"),
  BookModel(
    id: "4",
    title: "Nếu tôi biết khi còn 20",
    description:
        "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum",
    aboutAuthor: "hi my name is Nitish Roy and i have written this book",
    audioLen: "20",
    author: "Nitish Roy",
    coverUrl: "Assets/Images/neutoibietduockhicon20.jpg",
    rating: "4.2",
    category: "Documentary",
    price: 100,
    pages: 234,
    language: "ENG",
    numberofRating: "10,",
    bookurl:
        "Assets/Bookss/neutoibietduockhicon20.pdf",
  )
];

// List<TheLoaiModel> theloaiData =[
//   TheLoaiModel(Id: 1, Ten: "TÌNH CẢM", CoverIMG:"Assets/Images/langman.jpg"),
//   TheLoaiModel(Id: 2, Ten: "LỊCH SỬ", CoverIMG:"Assets/Images/lichsu.jpg"),
//   TheLoaiModel(Id: 3, Ten: "NƯỚC NGOÀI", CoverIMG:"Assets/Images/nuocngoai.jpeg"),
//   TheLoaiModel(Id: 4, Ten: "TRINH THÁM", CoverIMG:"Assets/Images/trinhtham.jpg"),
//   TheLoaiModel(Id: 5, Ten: "KINH DỊ", CoverIMG:"Assets/Images/kinhdi.jpg"),
//   TheLoaiModel(Id: 6, Ten: "KHOA HỌC", CoverIMG:"Assets/Images/khoahoc.jpg"),
//   TheLoaiModel(Id: 7, Ten: "KINH TẾ", CoverIMG:"Assets/Images/kinhte.jpeg"),
//   TheLoaiModel(Id: 8, Ten: "NGỤ NGÔN", CoverIMG:"Assets/Images/ngungon2.jpg"),
//   TheLoaiModel(Id: 9, Ten: "HÀI HƯỚC", CoverIMG:"Assets/Images/langman.jpg"),
//   TheLoaiModel(Id: 10, Ten: "PHIÊU LƯU", CoverIMG:"Assets/Images/phieuluu2.webp"),
//   TheLoaiModel(Id: 11, Ten: "TÀI CHÍNH", CoverIMG:"Assets/Images/taichinh2.jpg"),
//   TheLoaiModel(Id: 12, Ten: "TIỂU THUYẾT", CoverIMG:"Assets/Images/nuocngoai.jpeg"),
// ];
List<AuthorModel> tacGiaData = [
  AuthorModel(hovaten: "Nguyen", namsinh: "2023", quequan: "Hà Nội", coverImage: "Assets/Images/book.png"),
  AuthorModel(hovaten: "Nguyen", namsinh: "2023", quequan: "Hồ Chí Minh", coverImage: "Assets/Images/boundraries.jpg"),
  AuthorModel(hovaten: "Nguyen Hoang", namsinh: "2023", quequan: "Hà Nội", coverImage: "Assets/Images/book.png"),
  AuthorModel(hovaten: "Nguyen", namsinh: "2023", quequan: "Hà Nội", coverImage: "Assets/Images/book.png"),
  AuthorModel(hovaten: "Nguyen", namsinh: "2023", quequan: "Hà Nội", coverImage: "Assets/Images/book.png"),
  AuthorModel(hovaten: "Ha", namsinh: "2023", quequan: "Hà Nội", coverImage: "Assets/Images/book.png"),


];