import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:url_launcher/url_launcher.dart';


import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:guideme/LoginPage.dart';
import 'package:guideme/homeCall.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'IndexStudent.dart';
import 'emailPlugin.dart';
import 'tutor.dart';
import 'signup.dart';
import 'Listing.dart';
import 'Edit.dart';

void main() => runApp(new MyApp());
String dropdownValue;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/tutor': (BuildContext context) => new tutor(),
        '/Listing': (BuildContext context) => new Listing(),
        '/Edit': (BuildContext context) => new Edit()
      },
      home: new LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  Future getUsers() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Admin").getDocuments();
    return qn.documents;
  }
@override
  List<DropdownMenuItem<String>> ListDrop = [];
final GlobalKey<FormState> _uKey=GlobalKey<FormState>();
String _email, _password;
final databaseReference = Firestore.instance;
var myrating;
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(12.0, 100.0, 0.0, 0.0),
                    child: Text('Guide',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 190.0, 0.0, 0.0),
                    child: Text('Me',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold,)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 300.0, 0.0, 0.0),
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
                  Container(
                    padding: EdgeInsets.fromLTRB(142.0, 190.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 1.0, left: 20.0, right: 20.0),

                child: Form(
                  key: _uKey,
                  child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator:(input){
                        if(input.isEmpty){
                          return "Type an Email";
                        }
                      } ,
                      onSaved: (input)=>_email =input,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),),


                    TextFormField(
                      validator:(input){
                        if(input.length < 6){
                          return "Type a password with at least 6 charachters";
                        }
                      } ,
                      onSaved: (input)=>_email =input,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                    RaisedButton(
                      // ignore: missing_return
                      onPressed: (){
                        if(dropdownValue=="Admin") {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => LoginPage()));
                        }
                        else if(dropdownValue=="Student"){
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => Student()));
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "This is Center Short Toast",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
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
                    



                  ],
                ),
                ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12.0, 100.0, 0.0, 0.0),

              child: RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),

            ),],
        ));
  }
void getData() {


  databaseReference
      .collection("Admin")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => print('${f.data['password']}')
    );


  });
}
void createRecord() async {
  await databaseReference.collection("tudent")
      .document("abdulz@gmail.com")
      .setData({
    'firstname': 'Mastering Flutter',
    'email': 'Programming Guide for Dart'
  });

}
Future<void>  signIn() async {
  final _form = _uKey.currentState;

    _form.save();
    AuthResult u = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password));
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Admin()));
}

  sign_up() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> sign_up()));

  }


      }
class Admin extends StatelessWidget {

  @override
  String email;
  String firstname;

  Admin({this.email, this.firstname});
  Widget build(BuildContext context) {
    return new Scaffold( drawer: Drawer(
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
            title: Text('Students Page'),
            onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Student()));
            },
          ),
          ListTile(
            title: Text('Tutors Page'),
            onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
            },
          ),
          ListTile(
            title: Text('Guide Me Video Service'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                    child: Text('Admin',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 130.0, 0.0, 0.0),
                    child: Text('Page',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),

                ],
              ),
            ),
            SizedBox(height: 60.0),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50.0,
                width: 250,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      "Add Student",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50.0,
                  width: 250,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/tutor');
                      },
                      child: Text(
                        "Add Tutor",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                )),
            SizedBox(height: 40.0),
            Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50.0,
                  width: 250,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Listing');
                      },
                      child: Text(
                        "List All Users Tutors/Students",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                )),
            SizedBox(height: 40.0),
            Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50.0,
                  width: 250,
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Edit');
                      },
                      child: Text(
                        "Edit User's Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ))
          ],
        ));
  }
}

class Student extends StatelessWidget {
  String email;
var myrating;
  Student({this.email});
  String firstname, lastname, field, degree,availability,search=" ";
  Future getCourses() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Tutor").getDocuments();
    return qn.documents;
  }
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
          content: new Text("if you press yes you will recieve an email to reset your password."),
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
                sendPasswordResetEmail(email);
                Navigator.pop(context);
              },

            ),
          ],
        );
      },
    );
  }
  _launchURL() async {
    const url = 'https://solutions.agora.io/education/web/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<List<DocumentSnapshot>> getSuggestion(String suggestion) =>

      Firestore.instance
          .collection('Tutor')
          .orderBy('field_of_expertise')
          .startAt([suggestion])
          .getDocuments()
          .then((snapshot) {
        return snapshot.documents;
      });

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPageSt(email: email,)));
            },
          ),
          ListTile(
            title: Text('Reset Your Password'),
            onTap: () {
_showDialog(context);},
          ),
          ListTile(
            title: Text('Attend Class'),
            onTap: () =>{_launchURL()},
          ),
        ],),),


      resizeToAvoidBottomInset:false,

      resizeToAvoidBottomPadding: false,
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
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  child: Text('Explore',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 75.0, 0.0, 40.0),
                  child: Text('Tutors',
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.top,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(16.0, 140.0, 0.0, 40.0),

                    child: TextFormField(
                      onChanged: (input) => search = input,

                      decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),)
                    
                ),



                Container(


                  padding: EdgeInsets.fromLTRB(0.0, 200.0, 30.0, 0.0),

                  child: FutureBuilder(

                      future: getSuggestion(search),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {

                          return
                            Center(
                              child: Text("Loading..."),
                            );
                        } else {
                          return ListView.builder(
                              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 50.0),

                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                return Card(


                                    child: ListTile(
                                    onTap: () => rating(snapshot.data[index].data["email"],context),

                                      title: Text(
                                          snapshot.data[index].data["first_name"]+" "
                                              +snapshot.data[index].data["last_name"]),
                                      subtitle: Text(
                                          "Expert in: " + snapshot.data[index].data["field_of_expertise"]+
                                              "\nAvailability: " +snapshot.data[index].data["availability"]+
                                              "\nDegree: " +snapshot.data[index].data["degree"]+
                                              "\nRating: " +snapshot.data[index].data["rating"].toString()
                                              //"\nEmail: "+ snapshot.data[index].data["email"]
                                      ),



                                      //   trailing: snapshot.data[index].data["availability"],
                                      trailing: IconButton(icon: Icon(Icons.email), onPressed:()=>    get(email,context,snapshot.data[index].data["email"])
                                        //
                                        // { Navigator.push(context,MaterialPageRoute(builder:(context)=>emailPlug()));}



                                      ),

                                    )

                                );
                              });
                        }
                      }),
                ),
//                Container(
//
//                  padding: EdgeInsets.fromLTRB(0.0, 200.0, 30.0, 0.0),
//
//                  child: FutureBuilder(
//
//                      future: getCourses(),
//
//                      builder: (_, snapshot) {
//                        if (snapshot.connectionState ==
//                            ConnectionState.waiting) {
//                          return
//                            Center(
//                            child: Text("Loading..."),
//                          );
//                        } else {
//                          return ListView.builder(
//                              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 50.0),
//
//                              scrollDirection: Axis.vertical,
//                              shrinkWrap: true,
//                              itemCount: snapshot.data.length,
//                              itemBuilder: (_, index) {
//                                return Card(
//
//
//                                  child: ListTile(
////                                    onTap: () => Navigator.push(context,MaterialPageRoute(builder:(context)=>Detailed()))
//
//                                    title: Text(
//                                          snapshot.data[index].data["first_name"]+" "
//                                              +snapshot.data[index].data["last_name"]),
//                                      subtitle: Text(
//                                          "Expert in: " + snapshot.data[index].data["field_of_expertise"]+
//                                              "\navailability: " +snapshot.data[index].data["availability"]+
//                                              "\ndegree: " +snapshot.data[index].data["degree"]+
//                                          "\nEmail: "+ snapshot.data[index].data["email"]
//                                      ),
//
//
//
//                                 //   trailing: snapshot.data[index].data["availability"],
//                                      trailing: IconButton(icon: Icon(Icons.email), onPressed:() { Navigator.push(context,MaterialPageRoute(builder:(context)=>emailPlug()));}
//
//
//                                  ),
//
//                                  )
//
//                                );
//                              });
//                        }
//                      }),
//                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    ),
    ),
      ),
    );
  }
  void check(int sessions, BuildContext context,email){
if(sessions  < 2){
  Navigator.push(context,MaterialPageRoute(builder:(context)=>emailPlug(email: email)));
}
else{
  Fluttertoast.showToast(
      msg: "you have exceeded the maximum number of requests.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);

}
  }
  void get(String email, BuildContext context,String Tmail) {
    int sessions, total;
    Firestore.instance.collection('Student')
        .document(email)
        .get()
        .then((DocumentSnapshot document) {
      sessions = document['num_of_weekly_sessions'];
      total = document['num_of_sessions'];
      print("num_of_weekly_sessions:$sessions");
      check(sessions,context,Tmail);

    });
  }

  void rating(String email, BuildContext context){

    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const FlutterLogo(
                size: 0,
                colors: Colors.red),
            title: "Rating",
            description:
            "Tap a star to set your rating.",
            submitButton: "SUBMIT",
            // optional
            positiveComment: "We are so happy to hear :)",
            // optional
            negativeComment: "We're sad to hear :(",
            // optional
            accentColor: Colors.green,
            // optional
            onSubmitPressed: (int rating) {
            //  print("onSubmitPressed: rating = $rating");
           // UpdateRating(email,rating);
              getRate(email, rating);


            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
            },
          );
        });

  }
  void getRate(String e, int rating) {
    var total;
    var count;
    Firestore.instance.collection('Tutor')
        .document(e)
        .get()
        .then((DocumentSnapshot document) {
      total = document['totalRate'];
      count= document["countRate"];
      UpdateRating(e,rating,count,total);

    });

  }
  void UpdateRating(String e,int rating,var count,var total) async {
    print(e);
   var totalrate=total+rating;
   myrating=(totalrate/(count+1))as double;

    await databaseReference.collection("Tutor")
        .document(e)
        .updateData({
      "totalRate":totalrate as int,
      "countRate": count + 1,
      "rating":myrating  ,

    });
    Fluttertoast.showToast(
        msg: "Thank you for your feedback!! ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

  }

  }
  
class Detailed extends StatelessWidget {
  String firstname, lastname, field, degree,availability;
  Detailed({this.firstname,this.degree,this.availability,this.field,this.lastname});

  Future getCourses() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Tutor").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0.0, 275.0, 0.0, 0.0),

              child: Text("$firstname")
          ),
        ],
      ),
    );
  }
}



