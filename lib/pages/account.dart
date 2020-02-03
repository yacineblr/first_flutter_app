import 'dart:async';

import 'package:flutter/material.dart';

import '../authentication_state.dart';

class AccountPage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamControllerAuth;

  const AccountPage(this._streamControllerAuth);

  signOut() {
    _streamControllerAuth.add(AuthenticationState.signedOut());
  }

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Center(
          child: RaisedButton(
            child: Text('Sign Out'),
            onPressed: widget.signOut,
          ),
        ),
      ),
    );
  }
}