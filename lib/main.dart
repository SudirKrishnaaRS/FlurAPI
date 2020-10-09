// import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'entities/note.dart';
// import 'constants.dart';
// import 'package:http/http.dart' as http;
import 'HomePage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlurAPI',
      theme: //ThemeData.dark(),
          ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}


