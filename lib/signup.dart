import 'package:flutter/material.dart';
import 'package:project/homepage.dart';
// import 'package:project/start.dart';
import 'package:project/login.dart';
import 'package:project/methods.dart';
import 'package:project/homepage.dart';
// import 'package:project/methods.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isloading
          ? Center(
              child: Container(
                height: size.height / 15,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: size.width / 1.05,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 1.2,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.2,
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      alignment: Alignment.center,
                      child: field(size, "user name", Icons.account_box, _name),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    child: field(size, "email", Icons.account_box, _email),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      alignment: Alignment.center,
                      child: field(size, "password", Icons.lock, _password),
                    ),
                  ),
                  SizedBox(height: 10),
                  custombutton(size),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LoginScreen())),
                    child: Text(
                      "Already have an Account? Login",
                      style: TextStyle(
                        color: Colors.deepPurpleAccent[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget custombutton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isloading = true;
          });

          signUp(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isloading = true;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Homepage()));
              print("Account created");
            } else {
              print("Account creation failed");
              setState(() {
                isloading = false;
              });
            }
          });
        } else {
          print("Login successful");
        }
      },
      child: Container(
        height: size.height / 14,
        width: size.width / 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurpleAccent[700],
        ),
        alignment: Alignment.center,
        child: Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      alignment: Alignment.topLeft,
      height: size.height / 15,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
