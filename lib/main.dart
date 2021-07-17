import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/about.dart';
import 'package:project/addgroup.dart';
import 'package:project/authentication.dart';
import 'package:project/homepage.dart';
import 'package:project/login.dart';
import 'package:project/profile.dart';
import 'package:project/search.dart';
import 'package:project/settings.dart';
// import 'package:project/login.dart';
import 'package:project/signup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authentication(),
        //first video in last main page changed to authentication page and not login screen.
        routes: <String, WidgetBuilder>{
          "Login": (BuildContext context) => LoginScreen(),
          "SignUp": (BuildContext context) => Signup(),
          // "Start": (BuildContext context) => Start(),
          "Profile": (BuildContext context) => Profile(),
          "Homepage": (BuildContext context) => Homepage(),
          //   "Notification": (BuildContext context) => NotificationScreen(),
          "About": (BuildContext context) => About(),
          "AddGroup": (BuildContext context) => Addgroups(),
          "Settings": (BuildContext context) => Settings(),
          "Search": (BuildContext context) => Search(),

          // },
        });
  }
}
