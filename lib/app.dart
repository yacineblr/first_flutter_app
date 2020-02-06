import 'dart:async';

import 'package:flutter/material.dart';
import 'authentication_state.dart';
import 'pages/signin.dart';
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

  HomePage _homePage;
  AccountPage _accountPage;
  SignInPage _signInPage;

  final _streamControllerAuth = new StreamController<AuthenticationState>();

  @override
  void initState() { 
    super.initState();
    _homePage = new HomePage();
    _accountPage = new AccountPage(_streamControllerAuth);
    _signInPage = new SignInPage(_streamControllerAuth);
  }

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

  Widget buildUi(BuildContext _context, AuthenticationState s) {
    List children = [
      _homePage,
      null
    ];
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
    ];
    if (s.authenticated) {
      children.add(_accountPage);
      items.add(BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')));
    } else {
      children.add(_signInPage);
      items.add(BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('SignIn')));
    }
    return Scaffold(
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
    );
  }

  @override
  void dispose() {
    _streamControllerAuth.close();
    super.dispose();
  }

}



