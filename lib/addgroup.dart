import 'package:flutter/material.dart';

class Addgroups extends StatefulWidget {
  const Addgroups({Key? key}) : super(key: key);

  @override
  _AddgroupsState createState() => _AddgroupsState();
}

class _AddgroupsState extends State<Addgroups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepPurpleAccent[700],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
