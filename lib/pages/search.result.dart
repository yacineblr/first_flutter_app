import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text('SearchResult')),
    );
  }
}