import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/homepage.dart';
import 'package:project/login.dart';
import 'package:project/homepage.dart';

class Authentication extends StatelessWidget {
  Authentication({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Homepage();
    } else {
      return LoginScreen();
    }
  }
}
