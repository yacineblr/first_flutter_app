import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/pages/signin.dart';
import 'authentication_state.dart';
import 'pages/home.dart';
// import 'pages/search.dart';
import 'pages/account.dart';

class App extends StatefulWidget {
  
  @override
  _AppState createState() => _AppState();
  
}


class _AppState extends State<App> {

  int _saveCurrentIndexWhenPushSearch;
  int _currentIndex = 0;

  final _streamControllerAuth = new StreamController<AuthenticationState>();

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<AuthenticationState>(
      stream: _streamControllerAuth.stream,
      initialData: new AuthenticationState.initial() ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        final state = snapshot.data;
        return buildUi(context, state);
      },
    );
  }

  Widget buildUi(BuildContext content, AuthenticationState s) {
    List children = [
      HomePage(),
      null
    ];
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
    ];
    if (s.authenticated) {
      children.add(AccountPage(_streamControllerAuth));
      items.add(BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')));
    } else {
      children.add(SignInPage(_streamControllerAuth));
      items.add(BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('SignIn')));
    }
    return MaterialApp(
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              if (index == 1) { // SearchPage Index
                _saveCurrentIndexWhenPushSearch = _currentIndex;
                Navigator.pushNamed(context, '/search').then((value) {
                  setState(() {
                    _currentIndex = _saveCurrentIndexWhenPushSearch;
                  });
                });
              }
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            items: items,
          ),
          body: children[_currentIndex],
        ),
    )
    ;
  }

  @override
  void dispose() {
    _streamControllerAuth.close();
    super.dispose();
  }

}



