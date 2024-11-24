import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/profilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfileScreen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState(){
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot){
                setState(() {
                  _nameController.text = documentSnapshot['name'];
                  _emailController.text = documentSnapshot['email'];
                });
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            
            ElevatedButton(
              onPressed: () {
                // Save the edited profile data to Firestore
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .update({
                    'name': _nameController.text,
                    'email': _emailController.text,
                  });
                  // Navigate back to profile screen
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
