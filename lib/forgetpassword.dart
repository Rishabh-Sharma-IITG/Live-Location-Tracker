import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/signup.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late String _email;
  var _formkey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepPurpleAccent[700],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 85.0),
          child: Text("Reset Password"),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
              color: Colors.deepPurpleAccent[700]!.withOpacity(0.8),
              fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Text('Forgot Password',
                          style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent[700])),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Please enter your email and we will send \n you a link to return to your account",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.deepPurpleAccent[700]),
                      ),
                      SizedBox(height: 100),
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return "Please enter the email";
                          } else {
                            _email = input;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          // icon: Icon(Icons.person_outline),
                          labelText: "Email",
                          hintText: "Enter your Email",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                            child: Icon(
                              Icons.mail_outline,
                              color: Colors.blueGrey[200],
                              size: 30,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Colors.black),
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Colors.black),
                            gapPadding: 10,
                          ),
                        ),
                        onSaved: (input) => _email = input!,
                        // onChanged: (input) {
                        //   setState(() {
                        //     _email = input;
                        //   });
                        // }
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text("Send Request",
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _email);
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          GestureDetector(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent[700]),
                            ),
                            onTap: navigateToSignUp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
