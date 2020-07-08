
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class About extends StatefulWidget {
  @override
  _About createState() => new _About();
}



class _About extends State<About> {

  @override

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: GradientAppBar(
        title: Text('Guide Me',
        textAlign: TextAlign.center,
    ),

    backgroundColorStart: Colors.green,
    backgroundColorEnd: Colors.greenAccent,
    ),
    resizeToAvoidBottomPadding: false,
    body: Stack(
        children: <Widget>[
    Container(
      padding: EdgeInsets.fromLTRB(12.0, 100.0, 0.0, 0.0),
      child: Text('About Us',
          style: TextStyle(
              fontSize: 45.0, fontWeight: FontWeight.bold)),
    ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 190.0, 0.0, 0.0),
            child: Text('Guide me platform is group of youth they believe in change and they want to make a change in all communities in the world they want to make a new world of online education they more creative ideas to make their lives easier and they believe in all ages they can make a world difference.',
                style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.normal,)),
          )
    ]
    )

    );
}}