import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:guideme/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'main.dart';

class EditAvailable extends StatefulWidget {
  @override

  String email;

  EditAvailable({this.email});
  _EditAvailable createState() => _EditAvailable(email: email);
}

String dropdownValue;

class _EditAvailable extends State<EditAvailable> {
  String email;

  _EditAvailable({this.email});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  var Av;
  final AvCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: GradientAppBar(
              title: Text('Guide Me',
                textAlign: TextAlign.center,
              ),  backgroundColorStart: Colors.green,
              backgroundColorEnd: Colors.greenAccent,
            ),
            resizeToAvoidBottomPadding: false,
            body: ListView(children: <
                Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(

                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Edit Available Time',
                        style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                      ),
                    ),


                  ],
                ),
              ),

              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: AvCont,
                        decoration: InputDecoration(
                            labelText: 'Available Times',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        onSaved: (input) => Av = input,
                      ),
                      SizedBox(height: 10.0),





                      Container(
                          height: 40.0,
                          child: Material(
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(30.0),

                            child: RaisedButton(
                              child: Center(
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),

                              ),
                              color: Colors.green,

                              onPressed: signUp ,
                            ),


                          )),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      SizedBox(height: 20.0),

                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child:

                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),


                          ),
                        ),
                      ),
                    ],
                  )),

            ]))
    );
  }
  void signUp() async {
    createRecord();

//    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailCont.text, password:passwordCont.text);
   // Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));



  }
  void createRecord() async {
    print(email);
    await databaseReference.collection("Tutor")
        .document(email)
        .updateData({
      "availability": AvCont.text,

    });
    Fluttertoast.showToast(
        msg: "Available Time has been updated!! ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

  }
}

