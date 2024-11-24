// import 'package:flutter_weather/Screens/homeScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_weather/utils/color_utils.dart';
// import 'package:flutter_weather/widgets/reusable_widget.dart';
// import 'package:flutter_weather/Screens/Login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_weather/Screens/SignUpScreen.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_weather/provider/weatherProvider.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         // margin: EdgeInsets.symmetric(vertical: 100.0),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           image: new DecorationImage(
//             image: new AssetImage('assets/images/cloud.jpg'),
//             fit: BoxFit.cover,
//           ),
//           // image: DecorationImage(
//           //   image: NetworkImage(
//           //       'https://i.pinimg.com/originals/e9/35/86/e93586d9df31af39388612c7ce5162f7.jpg'),
//           //   fit: BoxFit.contain,
//           // ),

//           // image: DecorationImage(
//           //   image: NetworkImage(
//           //       'https://i.pinimg.com/originals/e9/35/86/e93586d9df31af39388612c7ce5162f7.jpg'),
//           //   fit: BoxFit.cover,
//           // ),

//           // gradient: LinearGradient(colors: [
//           //   hexStringToColor("E1AFD1"),
//           //   hexStringToColor("AD88C6"),
//           //   hexStringToColor("7469B6")
//           // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).size.height * 0.3, 20, 0),
//             child: Column(
//               children: <Widget>[
//                 // logoWidget("assets/images/logo1.png"),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 reusableTextField("Enter Email", Icons.person_outline, false,
//                     _emailTextController),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField('Enter Password', Icons.lock_outline, true,
//                     _passwordTextController),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 signInSignUpButton(context, true, () {
//                   // Step 5
//                   FirebaseAuth.instance
//                       .signInWithEmailAndPassword(
//                           email: _emailTextController.text,
//                           password: _passwordTextController.text)
//                       .then((value) {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()));
//                   }).onError((error, stackTrace) {
//                     print("Error ${error.toString()}");
//                     // _scaffoldKey.currentState!.showSnackBar(
//                     //   SnackBar(
//                     //     content: Text(
//                     //         'Invalid email or password. Please try again.'),
//                     //   ),
//                     // );
//                   });
//                 }),
//                 signUpOption(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row signUpOption() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text("Don't have account?",
//             style: TextStyle(color: Color.fromARGB(179, 73, 72, 72))),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SignUpScreen()));
//           },
//           child: const Text(
//             " Sign Up",
//             style: TextStyle(
//                 color: Color.fromARGB(255, 56, 56, 56),
//                 fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:weather_app/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/color_utils.dart';
import 'package:weather_app/widgets/reusable_widget.dart';
import 'package:weather_app/Screens/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/Screens/SignUpScreen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weatherProvider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isValidEmail(String email) {
    // Sử dụng biểu thức chính quy để kiểm tra định dạng email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cloud.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.3, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  reusableTextField(
                    "Enter Email",
                    Icons.person_outline,
                    false,
                    _emailTextController,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null; // Trả về null nếu hợp lệ
                    },
                  ),
                  SizedBox(height: 20),
                  reusableTextField(
                    'Enter Password',
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null; // Trả về null nếu hợp lệ
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                       width: double.infinity,
                      child: TextButton(
                      onPressed: () {
                      _showForgotPasswordDialog(context); // Hiển thị hộp thoại quên mật khẩu
                      },
                       child: Text("Forgot password?", style: TextStyle(
                      fontSize: 14,
                    color: Color.fromRGBO(67, 104, 80, 0.6))),
            ),
          ),
                  signInSignUpButton(context, true, () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                        showLoginErrorDialog(context);
                      });
                    }
                  },
                  
                  ),
                  signUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String value) {
    bool isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    if (!isValid) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

   void _showForgotPasswordDialog(BuildContext context) {
    TextEditingController forgetPasswordController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Forgot Password"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: forgetPasswordController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Xử lý quên mật khẩu ở đây
                  var forgotEmail = forgetPasswordController.text.trim();
                  try {

                     // Kiểm tra xem email có được nhập hay không
                  if (forgotEmail.isEmpty) {
                    // errorMessage("Please enter your email");
                    return; // Dừng xử lý nếu email không được nhập
                  }
                    
                    FirebaseAuth.instance
                      . sendPasswordResetEmail(email: forgotEmail)
                      .then((value) => {print('Email Sent !')}) ;
                    
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));

                  } on FirebaseAuthException catch (e){
                    print(" Error $e");
                  }


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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Color.fromARGB(179, 73, 72, 72))),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Color.fromARGB(255, 56, 56, 56),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

void showLoginErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Invalid email or password. Please try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
