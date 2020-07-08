import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'flutter_email_sender.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';




class emailPlug extends StatefulWidget {
String email;
emailPlug({this.email});
    @override
    _MyAppState createState() => _MyAppState(email: email);

}

class _MyAppState extends State<emailPlug> {
    String email="";
    _MyAppState({this.email});
    List<String> attachments = [];
    bool isHTML = false;

    final _recipientController = TextEditingController();


    final _subjectController = TextEditingController(text: 'Request session token');

    final _bodyController = TextEditingController(
        text: 'Dear Tutor \nI would like to attend your session, please send me the sessions token/id ',
    );

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    Future<void> send() async {
        final Email email = Email(
            body: _bodyController.text,
            subject: _subjectController.text,
            recipients: [_recipientController.text],
            attachmentPaths: attachments,
            isHTML: isHTML,
        );

        String platformResponse;

        try {
            await FlutterEmailSender.send(email);
            platformResponse = 'success';
        } catch (error) {
            platformResponse = error.toString();
            print(platformResponse);
        }

        if (!mounted) return;

        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(platformResponse),
        ));
    }

    @override
    Widget build(BuildContext context) {

        return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(primaryColor: Colors.green),
            home: Scaffold(
                key: _scaffoldKey,


                appBar: GradientAppBar(
                    title: Text('Request Token Plugin'),
                    actions: <Widget>[
                        IconButton(
                            onPressed: ()=> send(),
                            icon: Icon(Icons.send),
                        )
                    ],
                    backgroundColorStart: Colors.green,
                    backgroundColorEnd: Colors.greenAccent,
                ),
                body: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(

                            mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                        onTap: ()=> _recipientController.text=email,
                                        controller: _recipientController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Tap here to get Tutor email',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                        controller: _subjectController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Subject',
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                        controller: _bodyController,
                                        maxLines: 10,
                                        decoration: InputDecoration(
                                            labelText: 'Body', border: OutlineInputBorder()),
                                    ),
                                ),

                                ...attachments.map(
                                        (item) => Text(
                                        item,
                                        overflow: TextOverflow.fade,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                    icon: Icon(Icons.camera),
                    label: Text('Add Image'),
                    backgroundColor: Colors.greenAccent,
                    onPressed: _openImagePicker,
                ),
            ),
        );
    }

    void _openImagePicker() async {
        File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
            attachments.add(pick.path);
        });
    }
}
