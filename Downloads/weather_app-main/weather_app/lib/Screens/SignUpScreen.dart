import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_app/utils/color_utils.dart';
import 'package:weather_app/widgets/reusable_widget.dart';
import 'package:weather_app/Screens/Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // GlobalKey cho Form
  File? _image; // Ảnh đại diện của người dùng

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      _image = File(pickedImage.path);
    });
  }
}

Future<String?> _uploadImageToFirebaseStorage() async {
  try {
    if (_image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      print('No image selected.');
      return null;
    }
  } catch (error) {
    print('Error uploading image to Firebase Storage: $error');
    return null;
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Form(
              key: _formKey, // Gắn GlobalKey vào Form
              autovalidateMode:
                  AutovalidateMode.onUserInteraction, // Kích hoạt autovalidate
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Enter Username",
                    Icons.person_outline,
                    false,
                    _userNameTextController,
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null; // Trả về null nếu hợp lệ
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Enter Email Address",
                    Icons.email_outlined,
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
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    " Enter Password",
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
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap:
                     _pickImage,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/images/cloud.jpg') as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        String? avatarUrl = await _uploadImageToFirebaseStorage();
                        UserCredential userCredential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                        );
                        String uid = userCredential.user!.uid;
                        await FirebaseAuth.instance.currentUser!.updateDisplayName(_userNameTextController.text);
                        await FirebaseAuth.instance.currentUser!.updatePhotoURL(avatarUrl);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      } catch (error) {
                        print("Error $error");
                      }
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}






// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_weather/utils/color_utils.dart';
// // import 'package:flutter_weather/widgets/reusable_widget.dart';
// // import 'package:flutter_weather/Screens/Login.dart';

// // class SignUpScreen extends StatefulWidget {
// //   const SignUpScreen({Key? key}) : super(key: key);

// //   @override
// //   _SignUpScreenState createState() => _SignUpScreenState();
// // }

// // class _SignUpScreenState extends State<SignUpScreen> {
// //   TextEditingController _passwordTextController = TextEditingController();
// //   TextEditingController _emailTextController = TextEditingController();
// //   TextEditingController _userNameTextController = TextEditingController();

// //   // String? validateEmail(String value) {
// //   //   bool isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// //   //   if (!isValid) {
// //   //     return 'Invalid email address';
// //   //   }
// //   //   return null;
// //   // }

// //   // String? validatePassword(String value) {
// //   //   if (value.length < 6) {
// //   //     return 'Password must be at least 6 characters long';
// //   //   }
// //   //   return null;
// //   // }

// //   bool isValidEmail(String email) {
// //     // Sử dụng biểu thức chính quy để kiểm tra định dạng email
// //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
// //     return emailRegex.hasMatch(email);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         extendBodyBehindAppBar: true,
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           title: const Text(
// //             "Sign Up",
// //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         body: Container(
// //           width: MediaQuery.of(context).size.width,
// //           height: MediaQuery.of(context).size.height,
// //           decoration: BoxDecoration(
// //             image: new DecorationImage(
// //               image: new AssetImage('assets/images/cloud.jpg'),
// //               fit: BoxFit.cover,
// //             ),

// //             // image: DecorationImage(
// //             //   image: NetworkImage(
// //             //       'https://i.pinimg.com/originals/e9/35/86/e93586d9df31af39388612c7ce5162f7.jpg'),
// //             //   fit: BoxFit.contain,
// //             // ),
// //             // gradient: LinearGradient(colors: [
// //             //   hexStringToColor("E1AFD1"),
// //             //   hexStringToColor("AD88C6"),
// //             //   hexStringToColor("7469B6")
// //             // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
// //           ),
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
// //               child: Column(
// //                 children: <Widget>[
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   reusableTextField(
// //                     "Enter Username",
// //                     Icons.person_outline,
// //                     false,
// //                     _userNameTextController,
// //                     (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter your name';
// //                       }
// //                     },
// //                   ),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   reusableTextField(
// //                     "Enter Email Address",
// //                     Icons.email_outlined,
// //                     false,
// //                     _emailTextController,
// //                     (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter your email';
// //                       }
// //                       if (!isValidEmail(value)) {
// //                         return 'Please enter a valid email';
// //                       }
// //                       return null; // Trả về null nếu hợp lệ
// //                     },
// //                   ),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   reusableTextField(
// //                     " Enter Password",
// //                     Icons.lock_outline,
// //                     true,
// //                     _passwordTextController,
// //                     (value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter your password';
// //                       }
// //                       if (value.length < 6) {
// //                         return 'Password must be at least 6 characters';
// //                       }
// //                       return null; // Trả về null nếu hợp lệ
// //                     },
// //                   ),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   signInSignUpButton(context, false, () {
// //                     /* Step 3:  This function will create our
// //                    authentication.Once the username and email address is sent to the firebase
// //                    authentication it will create the account for you.

// //                    Step 4: go to home_screen.dart*/
// //                     FirebaseAuth.instance
// //                         .createUserWithEmailAndPassword(
// //                             email: _emailTextController.text,
// //                             password: _passwordTextController.text)
// //                         .then((value) {
// //                       print("Created New Account");
// //                       Navigator.push(context,
// //                           MaterialPageRoute(builder: (context) => Login()));
// //                     }).onError((error, stackTrace) {
// //                       print("Error ${error.toString()}");
// //                     });
// //                   })
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ));
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_app/utils/color_utils.dart';
// import 'package:weather_app/widgets/reusable_widget.dart';
// import 'package:weather_app/Screens/Login.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   TextEditingController _userNameTextController = TextEditingController();
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // GlobalKey cho Form

//   bool isValidEmail(String email) {
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     return emailRegex.hasMatch(email);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "Sign Up",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/cloud.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
//             child: Form(
//               key: _formKey, // Gắn GlobalKey vào Form
//               autovalidateMode:
//                   AutovalidateMode.onUserInteraction, // Kích hoạt autovalidate
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField(
//                     "Enter Username",
//                     Icons.person_outline,
//                     false,
//                     _userNameTextController,
//                     (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null; // Trả về null nếu hợp lệ
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField(
//                     "Enter Email Address",
//                     Icons.email_outlined,
//                     false,
//                     _emailTextController,
//                     (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!isValidEmail(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null; // Trả về null nếu hợp lệ
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   reusableTextField(
//                     " Enter Password",
//                     Icons.lock_outline,
//                     true,
//                     _passwordTextController,
//                     (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null; // Trả về null nếu hợp lệ
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   signInSignUpButton(context, false, () {
//                     // Kiểm tra xem form có hợp lệ không trước khi submit
//                     if (_formKey.currentState!.validate()) {
//                       FirebaseAuth.instance
//                           .createUserWithEmailAndPassword(
//                               email: _emailTextController.text,
//                               password: _passwordTextController.text)
//                           .then((value) {
//                         print("Created New Account");
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Login()));
//                       }).onError((error, stackTrace) {
//                         print("Error ${error.toString()}");
//                       });
//                     }
//                   })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
