
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class vision extends StatefulWidget {
  @override
  _vision createState() => new _vision();
}



class _vision extends State<vision> {

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
                padding: EdgeInsets.fromLTRB(12.0, 100.0, 10.0, 10.0),
                child: Text('Our Vision',
                    style: TextStyle(
                        fontSize: 45.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 190.0, 10.0, 10.0),
                child: Text('We strive to prepare all ages in the world to become lifelong learners and responsible citizens ready to meet the challenges of the future. In partnership with families and community, our goal is to create relevant learning opportunities for all that help them to develop their knowledge, and character necessary to succeed in advanced world. We believe we will be one of the best online platform in the world.to make a change in youth.',
                    style: TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.normal,)),
              )
            ]
        )

    );
  }}