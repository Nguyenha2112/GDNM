
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  late User _user;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Cho phép người dùng chọn ảnh từ thư viện ảnh 
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path); 
      });
    }
  }

  
 

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang cá nhân'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/images/cloud.jpg') as ImageProvider,
              ),
              SizedBox(height: 20.0),
              Text(
                // 'John Doe',
                _user.displayName ?? 'John Doe',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                // 'john.doe@example.com',
                _user.email ?? 'john.doe@example.com',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed:(){
                  Navigator.pushNamed(context, EditProfileScreen.routeName);
                },
                child: Text('Chỉnh sửa thông tin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfileScreen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: FirebaseAuth.instance.currentUser?.displayName ?? '');
    _emailController = TextEditingController(text: FirebaseAuth.instance.currentUser?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tên',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Nhập tên của bạn',
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Nhập email của bạn',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _saveChanges(context);
                },
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) async {
  String newName = _nameController.text;
  String newEmail = _emailController.text;

  try {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Thực hiện xác minh trước khi cập nhật email
      await currentUser.verifyBeforeUpdateEmail(newEmail);
      // Cập nhật tên người dùng
      await currentUser.updateDisplayName(newName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thông tin của bạn đã được cập nhật thành công')),
      );

      Navigator.pop(context);
    }
  } catch (error) {
    print('Đã xảy ra lỗi khi cập nhật thông tin người dùng: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xảy ra lỗi. Vui lòng thử lại sau.')),
    );
  }
}


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
