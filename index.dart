import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:guideme/editAvailable.dart';
import 'package:guideme/main.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guideme/signup.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';


// ignore: must_be_immutable
class IndexPage extends StatefulWidget {
    String email;

    IndexPage({this.email});
    final sCont = new TextEditingController();


    @override
    State<StatefulWidget> createState() => IndexState(email: email);





}
String token= DateTime.now().toString();
final _random = new Random();

class IndexState extends State<IndexPage> {
    String email,sessionName,foe;

    IndexState({this.email});
    final sCont = new TextEditingController();

    Future<void> sendPasswordResetEmail(String email) async {
        return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
    void _showDialog(BuildContext context) {
        // flutter defined function
        showDialog(
            context: context,
            builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                    title: new Text("Reset Conformation "),
                    content: new Text(
                        "if you press yes you will receive an email to reset your password."),
                    actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                            child: new Text("Cancel"),
                            onPressed: () {
                                Navigator.pop(context);
                            },
                        ),
                        new FlatButton(
                            child: new Text("Yes"),
                            onPressed: () {
                                print(email);
                                sendPasswordResetEmail(email);
                                Navigator.pop(context);
                            },

                        ),
                    ],
                );
            },
        );
    }

    /// create a channelController to retrieve text value
    final _channelController = TextEditingController();

    /// if channel textField is validated to have error
    bool _validateError = false;

    @override
    void dispose() {
        // dispose input controller
        _channelController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {

        return new Scaffold(drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                    DrawerHeader(
                        child: Text('Guide Me!'),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.green, Colors.greenAccent])
                        ),
                    ),

                    ListTile(
                        title: Text('Attend Session'),
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
                        },
                    ),
                    ListTile(
                        title: Text('reset your password'),
                        onTap: () {
                            _showDialog(context);},
                    ),
                    ListTile(
                        title: Text('Change available time'),
                        onTap: () {
                            print((email));
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAvailable(email :email)));
                            },
                    ),
                ],),),
            appBar: GradientAppBar(
                title: Text('Guide Me',
                    textAlign: TextAlign.center,
                ),  backgroundColorStart: Colors.green,
                backgroundColorEnd: Colors.greenAccent,
            ),
            body: Center(

                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 400,
                    child: Column(
                        children: <Widget>[
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: TextField(
                                            controller: _channelController,
                                            decoration: InputDecoration(
                                                errorText:
                                                _validateError ? 'meeting name is mandatory' : null,
                                                border: UnderlineInputBorder(
                                                    borderSide: BorderSide(width: 1),
                                                ),
                                                hintText: 'meeting token',
                                            ),
                                        ))
                                ],
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Column(

                                    children: <Widget>[
                                        Text("Please press on Generate to get new meeting token"),
                                        RaisedButton(

                                            onPressed:() =>get(),
                                            // onJoin(email),
                                            child: Text('Join',),
                                            color: Colors.green,
                                            textColor: Colors.white,
                                        ),

                                        RaisedButton(

                                            onPressed: generate,
                                            child: Text('Generate',),
                                            color: Colors.greenAccent,
                                            textColor: Colors.white,
                                        )


                                    ],
                                ),


                            )
                        ],
                    ),
                ),
            ),
        );
    }

    Future<void> onJoin(String s) async {

        // update input validation
        setState(() {
            _channelController.text.isEmpty
                ? _validateError = true
                : _validateError = false;
        });
        if (_channelController.text.isNotEmpty) {
            // await for camera and mic permissions before pushing video page
            await _handleCameraAndMic();
            // push video page with given channel name
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CallPage(
                        channelName: _channelController.text, email : s
                    ),
                ),
            );
        }
    }

    Future<void> _handleCameraAndMic() async {
        /*  await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );*/
    }
//    void dialog(){
//        showDialog(
//            context: context,
//            builder: (BuildContext context) {
//                return Dialog(
//                    shape: RoundedRectangleBorder(
//                        borderRadius:
//                        BorderRadius.circular(20.0)), //this right here
//                    child: Container(
//                        height: 200,
//                        child: Padding(
//                            padding: const EdgeInsets.all(12.0),
//                            child: Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                    TextFormField(
//                                        controller: sCont,
//                                        decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintText: 'Session Name'),
//                                        onSaved: (input)=> sessionName = input,
//                                    ),
//                                    SizedBox(
//                                        width: 320.0,
//                                        child: RaisedButton(
//                                            onPressed: get,
//                                            child: Text(
//                                                "Join in",
//                                                style: TextStyle(color: Colors.white),
//                                            ),
//                                            color:Colors.green,
//                                        ),
//                                    )
//                                ],
//                            ),
//                        ),
//                    ),
//                );
//            });
//
//    }
    void get() {
        Firestore.instance.collection('Tutor')
            .document(email)
            .get()
            .then((DocumentSnapshot document) {
            foe = document['field_of_expertise'];

        });
        createRecord();
    }
    void createRecord() async {
        await databaseReference.collection("Records")
            .document(_channelController.text)
            .setData({
            'Date': DateTime.now(),
            'Student': '',
            'Tutor':email
        });
    onJoin(email);}
        
    void generate()
    {

        Random rnd;
        int min = 99999999;
        int max = 1000000000;
        rnd = new Random();
        int r = min + rnd.nextInt(max - min);
        _channelController.text=r.toString();


    }
}
