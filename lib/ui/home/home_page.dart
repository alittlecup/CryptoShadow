import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'home_page_body.dart';
import 'package:cryptoshadow/ui/common/gradient_appbar.dart';
import 'package:cryptoshadow/theme.dart' as Theme;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {

  AnimationController _controller;
  static const List<IconData> icons = const [
    Icons.settings, Icons.view_list, Icons.payment];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
    new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GradientAppBar(title: "CryptoShadow"),
          HomePageBody(),
        ],
      ),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children:
        new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(
                    0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),),
              child: new FloatingActionButton(
                  backgroundColor: Theme.Colors2.colorBlue,
                  mini: true,
                  child: new Icon(
                    icons[index], color: Theme.Colors2.colorWhite,),
                  heroTag: 'hero-fab-' + index.toString(),
                  onPressed: () {
                    _controller.reverse();
                    changeFab(context, index);
                  }),
            ),
          );
          return child;
        }).toList()
          ..add(
              new FloatingActionButton(
                  child: new AnimatedBuilder(
                      animation: _controller, builder: (context, child) {
                    return new Transform(
                      transform: new Matrix4.rotationZ(
                          _controller.value * 0.5 * Math.pi),
                      alignment: FractionalOffset.center,
                      child: new Icon(
                          _controller.isDismissed ? Icons.add : Icons.close),
                    );
                  }),
                  onPressed: () {
                    if (_controller.isDismissed) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  })
          ),
      ),
    );
  }

  void changeFab(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        break;
      case 0:
        break;
      case 0:
        break;
    }
    Navigator.of(context).push(
        new PageRouteBuilder(pageBuilder: (_, __, ___) => page,
            transitionsBuilder: (context, animation, secondaryAnimation,
                child) => new FadeTransition(opacity: animation, child: child,))
    );
  }
}