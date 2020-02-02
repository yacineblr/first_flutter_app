import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/search.dart';
import 'pages/account.dart';

class App extends StatefulWidget {
  
  @override
  _AppState createState() => _AppState();
  
}


class _AppState extends State<App> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    null, // SearchPage Index
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              if (index == 1) { // SearchPage Index
                Navigator.pushNamed(context, '/search');
                return;
              }
              setState(() {
                _currentIndex = index;
              });
            }, // new
            currentIndex: _currentIndex, // new
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile')
              )
            ],
          ),
          body: _children[_currentIndex],
        ),
    );
  }

}



