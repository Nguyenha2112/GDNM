
import 'package:meapsbook/Config/Colors.dart';
import 'package:meapsbook/Pages/Homepage/HomePage.dart';
import 'package:meapsbook/Pages/ProfilePage/ProfilePage.dart';
import 'package:meapsbook/Pages/TacGia/TacGia.dart';
import 'package:meapsbook/Pages/settings_screen.dart';
import 'package:meapsbook/Pages/theloai/theloai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class NavBarRoots extends StatefulWidget {
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screens = [
    HomePage(),
    TacGia(),
    TheLoai(),
    ProfilePage(),
    SettingScreen(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_2_square_stack_fill,),label: "Tác Giả"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded), label: "Thể Loại"),
                 BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Tài Khoản"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Cài Đặt"),
          ],
        ),
      ),
    );
  }
}
