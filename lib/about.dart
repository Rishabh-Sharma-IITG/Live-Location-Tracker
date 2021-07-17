import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepPurpleAccent[700],
          ),
          onPressed: () {
            // Navigator.of(context).pushNamed("Homepage");
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
