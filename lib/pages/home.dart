import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lottie_4basic/flutter_lottie_4basic.dart';

import '../i18n.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      child: Column(children: <Widget>[
        // HomeLottieAnimation(),
        Text(I18n.of(context).appTitle)
      ])
    ));
  }

  @override
  void dispose() { 
    super.dispose();
  }
}

class HomeLottieAnimation extends StatefulWidget {
  HomeLottieAnimation({Key key}) : super(key: key);

  @override
  _HomeLottieAnimationState createState() => _HomeLottieAnimationState();
}

class _HomeLottieAnimationState extends State<HomeLottieAnimation> {
  LottieController controller;
  StreamController<double> newProgressStream;


  _HomeLottieAnimationState() {
    newProgressStream = new StreamController<double>();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    newProgressStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.387,
          child: LottieView.fromFile(
            filePath: "assets/animations/home.json",
            autoPlay: true,
            loop: true,
            onViewCreated: onViewCreatedFile,
          ),
        ),
        RaisedButton(
          onPressed: () async {
            print(this.newProgressStream.isPaused);
            controller.resume();
            // var playing = this.controller.isAnimationPlaying();
          },
          child: Text('Debug'),
        )
      ],)
    );
  }


  void onViewCreatedFile(LottieController controller) {
    this.controller = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller.setAnimationProgress(progress);
    });
  }
}

