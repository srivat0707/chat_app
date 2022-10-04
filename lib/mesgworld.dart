import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/custom.dart';
import 'package:http/http.dart' as http;

class screeen extends StatefulWidget {
  String? imaging;
  String? name;
  String? pid;
  String? iid;
  String? db;
  String? fcm;
  screeen(String fcm,String imaging, String name, String pid, String iid) {
    this.imaging = imaging;
    this.name = name;
    this.fcm = fcm;
    this.pid = pid;
    this.iid = iid;
    print("inside constructor");
    print(iid.compareTo(pid));
    if (iid.compareTo(pid) == -1) {
      db = iid + pid;
    } else {
      db = pid + iid;
    }
  }
  @override
  State<screeen> createState() => _screeenState();
}

class _screeenState extends State<screeen> {
  bool me = true;
  String? usr;
  // const screeen({Key? key}) : super(key: key);
  final tc = TextEditingController();
  void another() async {
    // final s = FirebaseFirestore.instance
    //     .collection("contacts")
    //     .doc("TTW1BBVoiljvVllUkdEY")
    //     .update({"online": 1});
    // print("sorted instance");
    // print(s);
    final prefs = await SharedPreferences.getInstance();
    usr = await prefs.getString('useraction')!;
    print(usr);
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    another();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Color.fromARGB(255, 244, 246, 248),
          toolbarHeight: 90,
          leadingWidth: 30,
          actions: [
            PopupMenuButton<int>(
              iconSize: 30,
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Logout')),
                PopupMenuItem<int>(value: 1, child: Text('Settings')),
              ],
            ),
          ],
          title: Row(
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(widget.imaging.toString()),
                  radius: 28),
              SizedBox(width: 15),
              Text(widget.name.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          )),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: StreamBuilder(
              builder: ((context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final List<DocumentSnapshot> documents = snapshot.data?.docs;
                  print(documents.length);
                  return ListView(
                    reverse: true,
                    children: documents.map((doc) {
                      another();
                      if (doc["userid"] == usr) {
                        me = true;
                      } else {
                        me = false;
                      }
                      print(me);
                      return Container(
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 40,
                            child: bubble(doc['msg'], me),
                            // child: ListTile(
                            //   horizontalTitleGap: 20,
                            //   //             leading: CircleAvatar(
                            //   // backgroundImage: NetworkImage(doc["image"].toString()),
                            //   // radius: 25),
                            //   title: Text(doc['msg']),
                            //   subtitle: Text(doc['time'].toString()),
                            // ),
                          ),
                        ),
                      );
                    }).toList(),
                    // padding:  EdgeInsets.all(28.0),
                    // children: documents
                    //     .map((doc) => Container(
                    //       width: 50,
                    //       child: Padding(
                    //             padding: const EdgeInsets.all(10.0),
                    //             child: Container(
                    //                   width: 40,
                    //                   child: bubble(doc['msg']),
                    //                   // child: ListTile(
                    //                   //   horizontalTitleGap: 20,
                    //                   //   //             leading: CircleAvatar(
                    //                   //   // backgroundImage: NetworkImage(doc["image"].toString()),
                    //                   //   // radius: 25),
                    //                   //   title: Text(doc['msg']),
                    //                   //   subtitle: Text(doc['time'].toString()),
                    //                   // ),
                    //                 ),
                    //               ),
                    //     ))
                    // .toList()
                  );
                }
              }),
              stream: FirebaseFirestore.instance
                  .collection("chat")
                  .doc(widget.db)
                  .collection("chats")
                  .orderBy("time", descending: true)
                  .snapshots(),
            ),
          )),
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 2),
                  width: 320,
                  child: TextField(
                    minLines: 1,
                    maxLines: 5, // allow user to enter 5 line in textfield
                    keyboardType: TextInputType.multiline,
                    controller: tc,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(30),
                          ),
                    ),
                  ),
                ),
                // SizedBox(width: 20),
                IconButton(
                  hoverColor: Colors.amberAccent,
                  color: Colors.amberAccent,
                  padding: const EdgeInsets.all(18.0),
                  onPressed: () async {
                    // Focus.of(context).dispose();
                    String? s = await FirebaseMessaging.instance.getToken();
                    print(s);
                    print(tc.text);
                    if (tc.text != "") {
                      FirebaseFirestore.instance
                          .collection("chat")
                          .doc(widget.db)
                          .collection("chats")
                          .add({
                        "msg": tc.text,
                        "time": Timestamp.now(),
                        "userid": usr
                      });
                      var url =
                          Uri.parse("https://fcm.googleapis.com/fcm/send");
                      var response = await http.post(url,
                          body: jsonEncode({
                            'notification': {
                              'title': 'Sending push form python script',
                              'body': 'New Message'
                            },
                            'to': widget.fcm,
                            'priority': 'high',
                          }),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'key=' +
                                "AAAAkM4LZUA:APA91bEJM9aM7NgkRmTMVmYax7dWyAOPDri_aKvW_9H_-tfvG4S9Vh7V5HgOA-pXB3akTNVVabE6qGuQ1H1pRH0jGkJYRDrTx4LxVTxEIFr7qemFUmkckEFM6G8cwTu_F9LsYXLtuF5b",
                          });
                      print('Response status: ${response.statusCode}');
                      tc.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
