import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User? loggedinuser;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");
  late String name, email, uid;
  signOut() async {
    _auth.signOut();
  }

  void getcurrentuser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getcurrentuser();
  }

  Future<void> userdata() async {
    final uid = loggedinuser!.uid;
    DocumentSnapshot ds = await userCollection.doc(uid).get();

    name = ds.get('name');
    email = ds.get('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepPurpleAccent[700],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text(
            'Settings',
            style: TextStyle(color: Colors.deepPurpleAccent[700]),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 5))
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://image.shutterstock.com/image-vector/user-silhouette-question-mark-vector-600w-251944267.jpg"),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              FutureBuilder(
                future: userdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text('loading....');
                  return Container(
                    padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                    child: Column(
                      children: [
                        Text(
                          "$name".toUpperCase(),
                          style: TextStyle(
                            color: Colors.deepPurpleAccent[700],
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                padding: EdgeInsets.only(top: 20),
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.deepPurpleAccent[700],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("Profile");
                },
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
