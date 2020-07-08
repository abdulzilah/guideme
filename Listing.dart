import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Listing extends StatefulWidget {
  @override
  _Listing createState() => _Listing();
}

String dropdownValue;


class _Listing extends State<Listing> {

    String firstname, lastname, field, degree,availability;
    Future getUsers() async {
      var firestore = Firestore.instance;
      if(dropdownValue=="Students"){
      QuerySnapshot qn = await firestore.collection("Student").getDocuments();
      return qn.documents;}
      else{
        QuerySnapshot qn = await firestore.collection("Tutor").getDocuments();
        return qn.documents;
      }
  }

  navigate(DocumentSnapshot std) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => details(student: std,)));
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: GradientAppBar(
        title: Text('Guide Me',
          textAlign: TextAlign.center,
        ),  backgroundColorStart: Colors.green,
        backgroundColorEnd: Colors.greenAccent,
      ),

      resizeToAvoidBottomPadding: false,
      body:Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(

        child:  Form(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                child: Text(
                  'Users ',
                  style:
                  TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(220.0, 40.0, 0.0, 0.0),

                child:
                new DropdownButton<String>(

                    isExpanded: true,
                    hint: Text('$dropdownValue',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Colors.black
                      ),),
                    items: <String>['Students', 'Tutors'].map((
                        String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      if (dropdownValue == 'All') {


                      }


                      setState(() {
                        dropdownValue = newValue;
                      });
                    }

                ),

              ),

             Container(

                padding: EdgeInsets.fromLTRB(0.0, 100.0, 50.0, 0.0),
                child: FutureBuilder(
                    future: getUsers(),
                    builder: (_, snapshot) {

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } else {
                        return ListView.builder(

                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),

                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length-0,
                            itemBuilder: (_, index) {
                              return Card(


                                  child: ListTile(
//                                    onTap: () => Navigator.push(context,MaterialPageRoute(builder:(context)=>Detailed()))

                                    title: Text(
                                        snapshot.data[index].data["first_name"]+" "
                                            +snapshot.data[index].data["last_name"]),
                                    subtitle: Text(
                                            "Email: "+ snapshot.data[index].data["email"]
                                                +"\n$dropdownValue"
                                    ),


                                    //   trailing: snapshot.data[index].data["availability"],
                                    trailing: IconButton(icon: Icon(Icons.android),
                                        //onPressed:() { Navigator.push(context,MaterialPageRoute(builder:(context)=>emailPlug()));}


                                    ),

                                  )
                              );
                            });

                      }

                    }),


),
    SizedBox(
    height: MediaQuery.of(context).viewInsets.bottom,

    )],
          ),

        ),


      ],
      ),
    )
    )
      )
    );
  }
}

class details extends StatefulWidget {
  final DocumentSnapshot student;

  details({this.student});

  _detailsState createState() => _detailsState();

}

class _detailsState extends State<details> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
      Widget>[
      Container(
      child: Stack(
          children: <Widget>[
          Container(
          padding: EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
      child: Text(
        'User Info',
        style:
        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
      ),
    ),
    Container(
    padding: EdgeInsets.fromLTRB(238.0, 120.0, 0.0, 0.0),
    child: Text(
    '.',
    style: TextStyle(
    fontSize: 80.0,
    fontWeight: FontWeight.bold,
    color: Colors.green),
    ),
    ),
    Container(
      padding: EdgeInsets.fromLTRB(0.0, 250.0, 0.0, 0.0),

      child: Card(
    child: ListTile(
    title: Text("Name: "+widget.student.data["firstname"]),
    subtitle: Text("Email: "+widget.student.data["email"])
    ,
    )
    ,
    )
    ,
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
}