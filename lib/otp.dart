import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/welcome.dart';

class otping extends StatefulWidget {
  String? verificationId;
  int? resendToken;
  otping(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    this.resendToken = resendToken;
  }

  @override
  State<otping> createState() => _otpingState();
}

class _otpingState extends State<otping> {
  bool is_loading = false;
  var t1 = TextEditingController();
  var t2 = TextEditingController();
  var t3 = TextEditingController();
  var t4 = TextEditingController();
  var t5 = TextEditingController();
  var t6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> sending() async {
      // Update the UI - wait for the user to enter the SMS code
      if (t2.text != "") {
        String smsCode =
            t1.text + t2.text + t3.text + t4.text + t5.text + t6.text;
        setState(() {
          is_loading = true;
        });
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                  child: Lottie.network(
                      "https://assets9.lottiefiles.com/private_files/lf30_ptsrzumi.json"));
            });
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId.toString(), smsCode: smsCode);

        // Sign the user in (or link) with the credential
        print("\n\n\n\n\nsent otp\n\n\n\n\n ");
        var t = await FirebaseAuth.instance.signInWithCredential(credential);
        print(t.user?.uid.toString());
        print(t.user);
        print(t);
        print(t.additionalUserInfo);
        print(t.additionalUserInfo?.providerId.toString());
        print(t.user?.uid.toString());
        print("logged_in");
        String? ans = "";
        ans = t.user?.uid;
        final prefs = await SharedPreferences
            .getInstance(); // Save an String value to 'action' key.
        await prefs.setString('useraction', ans.toString());
        final uuuid = await FirebaseMessaging.instance.getToken();
        print("\n\n\n\n\nuuuid\n\n\n\n\n");
        print(uuuid);
        if (t.additionalUserInfo?.isNewUser == false) {
        } else {
           await FirebaseFirestore.instance.collection("contacts").doc(ans).set({
            "Name": "anonymous user",
            "image":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRROuxtDXBOoxjAx8VrtoPF_9y_YJIOuPDzdQ&usqp=CAU",
            "uid": ans,
            "fcm":uuuid,
            "online": 1,
          });
          print("done");
        }
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (ctx) => welcoming(ans)));
      }
    }
    return Scaffold(body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        'https://i.pinimg.com/originals/c2/47/e9/c247e913a0214313045a8a5c39f8522b.jpg'))),
          ),
          SingleChildScrollView(
              child: is_loading
                  ? Center(
                      child: Lottie.network(
                          "https://assets9.lottiefiles.com/private_files/lf30_ptsrzumi.json"),
                    )
                  : Column(
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
                                  "Enter OTP",
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0, bottom: 18.0),
                                child: Container(
                                  child: Text(
                                      "Enter the otp correctly to login and avoid app crashes",style: TextStyle(color: Colors.white),),
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
                                padding: EdgeInsets.all(5.0),
                                child: Form(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      child: TextFormField(
                                        controller: t1,
                                        onChanged: (x) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        // maxLength: 1,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                      ),
                                      height: 80,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: t2,
                                        onChanged: (x) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        // maxLength: 1,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                      ),
                                      height: 80,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: t3,
                                        onChanged: (x) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        // maxLength: 1,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                      ),
                                      height: 80,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: t4,
                                        onChanged: (x) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        // maxLength: 1,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                      ),
                                      height: 80,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: t5,
                                        onChanged: (x) {
                                          FocusScope.of(context).nextFocus();
                                        },
                                        // maxLength: 1,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                      ),
                                      height: 80,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      child: TextFormField(
                                        controller: t6,
                                        // onChanged: (x) {
                                        //   FocusScope.of(context).nextFocus();
                                        // },
                                        // maxLength: 1,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                        ],
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0))),
                                      ),
                                      height: 80,
                                      width: 60,
                                    ),
                                  ],
                                ))),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  sending();
                                },
                                child: Text("submit")),
                          ],
                        )
                      ],
                    ),
            ),
        ],
      ),
    );
  }
}
