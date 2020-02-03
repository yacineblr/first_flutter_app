import 'dart:async';

import 'package:flutter/material.dart';

import '../authentication_state.dart';

class SignInPage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamControllerAuth;

  SignInPage(this._streamControllerAuth);

  signIn() async {
    _streamControllerAuth.add(AuthenticationState.authenticated());
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text('Sign in'),
          onPressed: widget.signIn,
        ),
      ),
    );
  }
}