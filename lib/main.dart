import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './pages/search.dart';
import 'app.dart';
import 'authentication_state.dart';
import 'i18n.dart';
import 'pages/account.dart';
import 'pages/home.dart';
import 'pages/signin.dart';

void main() => runApp(MainApp());



class MainApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext maincontext) {
      return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          const I18nDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('fr'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => App(),
          '/search': (context) => SearchPage()
        },
        /*onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => App());
              break;
            case '/search':
              return MaterialPageRoute(builder: (context) => SearchPage());
              break;
            default:
              return MaterialPageRoute(builder: (context) => Center(
                child: Text('Unknow route')
              ));
              break;
          }
        },*/
      );
  }
}


