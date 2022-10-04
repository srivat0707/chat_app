import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:warehouse/otp.dart';

class workingwithform extends StatefulWidget {
  workingwithform({Key? key}) : super(key: key);

  @override
  State<workingwithform> createState() => _workingwithformState();
}

class _workingwithformState extends State<workingwithform> {
  var one = TextEditingController();
  var two = TextEditingController();
  Future<void> sending() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Container(
            child: CircularProgressIndicator()
            )
            );
        }
        );
    FirebaseAuth mauth = await FirebaseAuth.instance;
    // mauth.setSettings(appVerificationDisabledForTesting: true);
    mauth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: "+91" + one.text,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: ((context) => otping(verificationId, resendToken))));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    // print(one.text);
    // print(two.text);
    // var url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCBPJRPotlbdVykdr53S7I6h0tDTw1676Y');
    // var response = await http.post(url,
    //     body: json.encode({
    //       'email': one.text,
    //       'password': two.text,
    //       'returnSecureToken': true
    //     }));
    // if (response.statusCode == 200) {
    //   Navigator.of(context)
    //       .pushReplacement(new MaterialPageRoute(builder: (ctx) {
    //     return welcome();
    //   }));
    // }
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Center(
    //     child: Container(
    //       child: Form(
    //             child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(18.0),
    //               child: TextFormField(
    //                 controller: one,
    //                 decoration: InputDecoration(
    //                   border: OutlineInputBorder(),
    //                   label: Text("Username"),
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(18.0),
    //               child: TextFormField(
    //                 controller: two,
    //                 decoration: InputDecoration(
    //                   label: Text("password"),
    //                   icon: Icon(Icons.people),
    //                 ),
    //               ),
    //             ),
    //             ElevatedButton(
    //                 onPressed: () {
    //                   sending();
    //                 },
    //                 child: Text("submit"))
    //           ],
    //         )),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     trchildren: [
    //       SizedBox(height: 200,),
    //       Container(child: Text("Sign in",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.left,)),
    //       Text("text"),
    //       Center(
    //         child: Container(
    //           width: 380,
    //           height: 200,
    //           padding: EdgeInsets.all(18.0),
    //           child: Form(
    //                 child: Column(
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(18.0),
    //                   child: TextFormField(
    //                     keyboardType: TextInputType.phone,
    //                     controller: two,
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //                       label: Text("Enter your mobile number"),
    //                       icon: Icon(Icons.phone_android),

    //                     ),
    //                   ),
    //                 ),
    //                 ElevatedButton(
    //                     onPressed: () {
    //                       sending();
    //                     },
    //                     child: Text("submit"))
    //               ],
    //             ),
    //             ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
            // Where the linear gradient begins and ends
            // begin: Alignment.topRight,
            // end: Alignment.bottomLeft,
            // Add one stop for each color. Stops should increase from 0 to 1
            // stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color.fromARGB(0, 244, 205, 239),
              Color.fromARGB(255, 209, 250, 232),
              // Color.fromARGB(255, 118, 125, 170),
              // Color.fromARGB(255, 221, 241, 168),
            ],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 18.0),
                      child: Container(
                        child: Text(
                            "We will send an SMS message to verify your phone number (carrier charges may apply)."),
                        width: 250,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    width: 380,
                    height: 200,
                    padding: EdgeInsets.all(18.0),
                    child: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: one,
                              decoration: InputDecoration(
                                focusColor: Color.fromARGB(255, 9, 9, 9),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 11, 11, 11),
                                      width: 2.0),
                                ),
                                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(90),),
                                label: Text("Enter your mobile number"),
                                labelStyle: TextStyle(color: Colors.black),
                                icon: Icon(
                                  Icons.phone_android,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                sending();
                              },
                              child: Text("submit"),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 59, 22, 221),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
