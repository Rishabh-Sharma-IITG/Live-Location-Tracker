import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.deepPurpleAccent[700],
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class DrawerSubItem extends StatelessWidget {
  DrawerSubItem({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          color: Colors.deepPurpleAccent[700]!.withOpacity(0.7),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
