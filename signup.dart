import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:guideme/main.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';




class SignupPage extends StatefulWidget {
  @override


  _SignupPageState createState() => _SignupPageState();
}
final format = DateFormat("yyyy-MM-dd");

final databaseReference = Firestore.instance;


class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  var firstname, password,lastname,email,level,dob,phone;
  final nameCont = new TextEditingController();
  final phoneCont = new TextEditingController();

  final passwordCont = new TextEditingController();
  final lnameCont = new TextEditingController();
  final emailCont = new TextEditingController();
  final levelCont=new TextEditingController();
  final dobCont=new TextEditingController();

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
                    'Sign up a Student',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ),

    Container(
                  padding: EdgeInsets.fromLTRB(210.0, 145.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
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
                    controller: nameCont,
                    decoration: InputDecoration(
                        labelText: 'FIRST NAME',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                onSaved: (input) => firstname = input,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller:lnameCont,

                    decoration: InputDecoration(
                        labelText: 'LAST NAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    onSaved: (input) => lastname = input,

                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller:phoneCont,

                    decoration: InputDecoration(
                        labelText: 'PHONE NUMBER ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    onSaved: (input) => phone = input,

                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller:levelCont,

                    decoration: InputDecoration(
                        labelText: 'Level Of Study',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    onSaved: (input) => level = input,

                  ),


                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: emailCont,

                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    onSaved: (input) => email = input,

                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: passwordCont,

                    decoration: InputDecoration(
                        labelText: 'PASSWORD (at least 6 charachters)',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                    onSaved: (input) => password = input,

                  ),

                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: dobCont,
                    decoration: InputDecoration(
                      labelText: "Date of birth",
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      hintText: "Ex. Insert your dob",),
                    onTap: () async{
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = await showDatePicker(
                          context: context,
                          initialDate:DateTime.now(),
                          firstDate:DateTime(1900),
                          lastDate: DateTime(2100));

                      dobCont.text = date.toString();},),




                  SizedBox(height: 50.0),
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
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),

                          ),
                          color: Colors.green,

                          onPressed: signUp,
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
                          print(dobCont);
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

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailCont.text, password:passwordCont.text);
    Navigator.of(context).pop();


  }
  void createRecord() async {
    if(dobCont.text.isNotEmpty && phoneCont.text.isNotEmpty && nameCont.text.isNotEmpty
    &&lnameCont.text.isNotEmpty && emailCont.text.isNotEmpty && passwordCont.text.isNotEmpty
    && levelCont.text.isNotEmpty && passwordCont.text.length>6) {
      await databaseReference.collection("Student")
          .document(emailCont.text)
          .setData({
        "date_of_birth": dobCont.text,
        "phone_number": phoneCont.text,
        'first_name': nameCont.text,
        'last_name': lnameCont.text,
        'email': emailCont.text,
        'password': passwordCont.text,
        "level_of_study": levelCont.text,
        "num_of_weekly_sessions":0,
        "num_of_sessions":0,
      });
    }else{
      Fluttertoast.showToast(
          msg: "Please check if all fields are filled properly!!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
