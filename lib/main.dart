import 'package:flutter/material.dart';
import 'package:my_app/pages/search.dart';
import 'app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => App(),
        '/search': (context) => SearchPage()
      },
    );
  }
}


