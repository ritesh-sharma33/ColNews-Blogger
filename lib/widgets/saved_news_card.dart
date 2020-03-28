import 'package:flutter/material.dart';

class SavedNewsCard extends StatelessWidget {

  final String title;
  SavedNewsCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(this.title, style: TextStyle(color: Colors.black),),
    );
  }
}