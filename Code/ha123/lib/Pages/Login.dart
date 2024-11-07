import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meapsbook/Pages/SignUp.dart';
import 'package:meapsbook/Pages/settings_screen.dart';
import '../../Components/PrimaryButton.dart';
import 'navbar_roots.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Welcome",
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(67, 104, 80, 1.0)),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "EBook",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(67, 104, 80, 1.0)),
            ),
          ],
        ),
      ],
    );
  }

  _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 40),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromRGBO(67, 104, 80, 0.1),
            filled: true,
            prefixIcon: Icon(Icons.person, color: Color.fromRGBO(67, 104, 80, 1.0)),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromRGBO(67, 104, 80, 0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(67, 104, 80, 1.0)),
          ),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _loginWithEmailPassword,
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  void _loginWithEmailPassword() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in both email and password",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      // Thực hiện xác thực với email và mật khẩu
      // Giả sử đăng nhập thành công:
      // Điều hướng đến trang chính

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavBarRoots(),
          )
      );
    }
  }

  _forgotPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                _showForgotPasswordDialog(context);
              },
              child: Text(
                "Forgot password?",
                style: TextStyle(fontSize: 14, color: Color.fromRGBO(67, 104, 80, 0.6)),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryButton(
              btnName: "LOGIN WITH GOOGLE",
              ontap: () {
                // Thêm logic đăng nhập bằng Google ở đây
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Forgot Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng hộp thoại sau khi xử lý
                },
                child: Text("Reset Password"),
              ),
            ],
          ),
        );
      },
    );
  }

  _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Color.fromRGBO(67, 104, 80, 1.0)),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpForm()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Color.fromRGBO(67, 104, 80, 1.0)),
          ),
        ),
      ],
    );
  }
}
