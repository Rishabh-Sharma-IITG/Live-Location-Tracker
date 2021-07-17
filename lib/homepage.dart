import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/googlemap.dart';
import 'package:project/methods.dart';
import 'package:project/profile.dart';
import 'package:project/drawer_item.dart';
import 'package:project/search.dart';

import 'package:project/location.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController nameController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  // navigateToStart() async {
  //   Navigator.pushReplacementNamed(context, "Start");
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.arrow_back_ios_new,
          //     color: Colors.deepPurpleAccent[700],
          //   ),
          //   onPressed: navigateToStart,
          // ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.deepPurpleAccent[700],
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("Search");
                  }),
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert_outlined,
                color: Colors.deepPurpleAccent[700],
                size: 30,
              ),
              onPressed: () {
                _scaffoldkey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            elevation: 1,
            onPressed: () {
              Navigator.of(context).pushNamed("AddGroup");
            },
            child: Icon(
              Icons.comment,
              size: 40,
            ),
            backgroundColor: Colors.deepPurpleAccent[700],
          ),
        ),
        endDrawer: ClipPath(
          clipper: _DrawerClipper(),
          child: Drawer(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                height: (orientation == Orientation.portrait)
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.deepPurpleAccent[700],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    DrawerItem(
                      text: "Profile",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("Profile");
                      },
                    ),
                    DrawerItem(
                      text: "My Contacts",
                      onPressed: () {},
                    ),
                    DrawerItem(
                      text: "Groups",
                      onPressed: () {},
                    ),
                    DrawerSubItem(
                      text: "Group-1",
                      onPressed: () {},
                    ),
                    DrawerSubItem(
                      text: "Group-2",
                      onPressed: () {},
                    ),
                    DrawerSubItem(
                      text: "Group-3",
                      onPressed: () {},
                    ),
                    DrawerItem(
                      text: "Notifications",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("Notification");
                      },
                    ),
                    DrawerItem(
                      text: "Settings",
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed("Settings");
                      },
                    ),
                    DrawerItem(
                      text: "About",
                      onPressed: () {
                        Navigator.of(context).pushNamed("About");
                      },
                    ),
                    Spacer(),
                    Divider(
                      color: Colors.deepPurpleAccent[700],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _openSignOutDrawer(context);
                          },
                          child: Text(
                            "SignOut",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurpleAccent[700],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 10),

            SizedBox(height: 10),
            Center(
              child: Container(
                height: 100,
                child: Text(
                  "Welcome to Home page",
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            //user location normal gesture detector button
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Location())),
              child: Text(
                "Location",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),

            GestureDetector(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Googlemap())),
              child: Text(
                "Googlemaps",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => logout(context), child: Text("Logout"))
          ],
        ),
      );
    });
  }

  void _openSignOutDrawer(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            height: 180,
            color: Colors.deepPurpleAccent[700]!.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "Are you sure you want to sign out?",
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: () => logout(context),
                        color: Colors.white,
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            color:
                                Colors.deepPurpleAccent[700]!.withOpacity(0.8),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white,
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        child: Text(
                          "Stay Logged In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
