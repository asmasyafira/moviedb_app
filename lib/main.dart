import 'package:flutter/material.dart';
import 'package:moviedb_app/view/home.dart';
import 'package:moviedb_app/view/home_tv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movie'),
          // title: Text('TvShow'),
          backgroundColor: Colors.pinkAccent,
        ),
        body: HomeScreen(),
        // body: HomeTvScreen(),
      ),
    );
  }
}

