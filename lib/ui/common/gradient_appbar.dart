import 'package:flutter/material.dart';
import 'package:cryptoshadow/theme.dart' as Theme;

class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 55.0;

  const GradientAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(title, style: TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 36.0,
        ),),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [
          Theme.Colors2.appBarGradientStart, Theme.Colors2.appBarGradientEnd],
            begin: FractionalOffset(0.0, 1.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),

    );
  }
}
