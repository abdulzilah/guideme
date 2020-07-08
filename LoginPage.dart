// ignore: avoid_web_libraries_in_flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:guideme/main.dart';
import 'package:guideme/index.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guideme/tutor.dart';
import 'index.dart';
import 'AboutUs.dart';
import 'vision.dart';
import 'package:progress_dialog/progress_dialog.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

ProgressDialog pr;
class _LoginPageState extends State<LoginPage> {




  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, _password;
  String user_db_Email,lastname,firstnameT;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Logging in...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.greenAccent, fontSize: 10.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.green, fontSize: 12.0, fontWeight: FontWeight.w600)
    );

    permissionRequest();

    return new Scaffold(

        drawer: Drawer(
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
        title: Text('About Us'),
        onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => About()));

  },
      ),
      ListTile(
        title: Text('Our Vision'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => vision()));
    },
      ),
    ],),),


        resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset:false,


      appBar: GradientAppBar(
        title: Text('Guide Me',
          textAlign: TextAlign.center,
        ),

        backgroundColorStart: Colors.green,
        backgroundColorEnd: Colors.greenAccent,
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
    child: SingleChildScrollView(

       child:  Form(

          key: _formKey,
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                child: Text('Guide',
                    style: TextStyle(
                        fontSize: 60.0, fontWeight: FontWeight.bold,color: Colors.green,fontFamily: 'Montserrat')),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                child: Text('Me',
                    style: TextStyle(
                        fontSize: 50.0, fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
              ),


              Container(
                padding: EdgeInsets.fromLTRB(16.0, 100.0, 0.0, 0.0),
                child: new DropdownButton<String>(
                    hint: Text('$dropdownValue'),
                    items: <String>['Admin', 'Student', 'Tutor']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    }),
              ),
              TextFormField(

                validator: (input) {
                  if(input.isEmpty){
                    return 'Provide an email';
                  }
                },
                decoration: InputDecoration(

                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                ),
                onChanged: (input) => email = input,

              ),
              TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Longer password please';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))                ),
                onChanged: (input) => _password = input,
                obscureText: true,
              ),

              RaisedButton(

                padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),

                onPressed:
                search,
                child: Text("Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'
                  ),
                ),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          )
      ),
    ),
      ),
    );
  }


  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{

        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: _password)).user;

        if(dropdownValue=="Admin" && user_db_Email=='admin@mail.com'){


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Admin(email : email, firstname : user_db_Email)));}


       else if (dropdownValue=="Student" && user_db_Email==email){


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Student(email: email)));}

        else if (dropdownValue=="Tutor" && user_db_Email==email){


          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IndexPage(email: email)));}



        else{
          Fluttertoast.showToast(
            msg: "informations arent valid ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        }



      }catch(e){
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
  Future<void>  search() async{
    await pr.show();

    var user = await FirebaseAuth.instance.currentUser();
    print("$dropdownValue");
    var userQuery = Firestore.instance.collection(dropdownValue).where('email', isEqualTo: email);
    userQuery.getDocuments().then((data){
      user_db_Email = data.documents[0].data['email'];
      print("userdb in search : $user_db_Email");
      print("$email");
      signIn();

    });
  }
  permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
    );
    var result1 = await permissionValidator.microphone();
    if (result1) {
      // Do something;
    }
    var result = await permissionValidator.camera();
    if (result) {
      // Do something;
    }
  }


}