import 'package:flutter/material.dart';

class Document extends StatefulWidget {
  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Document')),
      body: Center(
        child: Text('Document Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}