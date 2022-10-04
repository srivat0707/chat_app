import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warehouse/mesgworld.dart';

// import 'package:warehouse/newpage.dart';
void configLocalNotification() {
  var initializationSettingsAndroid = new AndroidInitializationSettings("");
  var initializationSettingsIOS = new IOSInitializationSettings();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void showNotification(message) async {
  print("1");
  print(message.notification.title);
  print("2");
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'Flutter chat demo', 'your channel description',
      playSound: true,
      enableVibration: true,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher');
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  print("i am called");
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title.toString(),
    message.notification?.body.toString(),
    platformChannelSpecifics,
  );
}

class welcoming extends StatefulWidget {
  String? uuis;
  welcoming(uuis) {
    this.uuis = uuis;
    // this.ss = ss;
    // this.name = ss!.displayName != null ? ss.displayName.toString() : "NONE";
    // this.urlofid = ss.photoUrl;
    // print(urlofid);
    // print(ss?.displayName.toString());
  }

  @override
  State<welcoming> createState() => _welcomingState();
}

class _welcomingState extends State<welcoming> with WidgetsBindingObserver {
  // GoogleSignInAccount? ss;
  String name = "none";

  String? urlofid = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state.toString());
  // }
  @override
  void initState() {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
    print(" \n\n\n\ncooking\n\n\n");
    WidgetsBinding.instance?.addObserver(this);
    print("added");
    final s = FirebaseFirestore.instance
        .collection("contacts")
        .doc(widget.uuis)
        .update({"online": 1});
    print(s);
    // var initialzationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettings =
    //     InitializationSettings(android: initialzationSettingsAndroid);
    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //   'high_importance_channel', // id
    //   'High Importance Notifications', // title
    //   description:
    //       'This channel is used for important notifications.', // description
    //   importance: Importance.high,
    // );
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    //     'high_importance_channel', // id
    //     'High Importance Notifications', // title
    //     description:
    //         'This channel is used for important notifications.', // description
    //     importance: Importance.high,
    //     playSound: true);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
    });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   _firebaseMessaging.getToken();
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.notification}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showNotification(message);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    print(" \n\n\n\ndisposed\n\n\n");
    print("deleted");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(" \n\n\n\nState\n\n\n");
    if (state == AppLifecycleState.inactive) {
      final s = await FirebaseFirestore.instance
          .collection("contacts")
          .doc(widget.uuis)
          .update({"online": 0});
      print("updated   done and dusted ");
    }
    if (state == AppLifecycleState.resumed) {
      final s = await FirebaseFirestore.instance
          .collection("contacts")
          .doc(widget.uuis)
          .update({"online": 1});
      print("updated   done and dusted ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 246, 248),
        // appBar: AppBar(
        //   leading: Builder(
        //     builder: (context) => InkWell(
        //       child: CircleAvatar(
        //           backgroundImage: NetworkImage(urlofid.toString()),
        //           radius: 15),
        //       onTap: () {
        //         print("yes");
        //         Scaffold.of(context).openDrawer();
        //       },
        //     ),
        //   ),
        // ),
        drawer: appsdrawer(),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gammadelta",
                      style: TextStyle(
                          color: Color.fromARGB(255, 13, 13, 13), fontSize: 25),
                    ),
                    Icon(
                      Icons.search,
                      size: 30,
                      color: Color.fromARGB(255, 6, 6, 6),
                    ),
                  ],
                ),
              ),
              height: 180,
              color: Color.fromARGB(255, 244, 246, 248),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90)),
                    color: Color.fromARGB(255, 236, 232, 223)),
                child: StreamBuilder(
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final List<DocumentSnapshot> documents =
                          snapshot.data?.docs;
                      documents
                          .removeWhere((element) => element.id == widget.uuis);
                      print("done");
                      return ListView(
                        shrinkWrap: true,
                        // padding:  EdgeInsets.all(28.0),
                        children: documents.map((doc) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              onTap: () {
                                print(doc);
                                print("\n\n\n\n\n\n\n\n\n");
                                print(doc.id);
//                                 const snackBar = SnackBar(
//                                   behavior: SnackBarBehavior.floating,
//                                   width: 100,
//                                   content: Text('Ya'),
//                                 );

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(snackBar);
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (ctx) => screeen(
                                          doc["fcm"],
                                            doc["image"],
                                            doc["Name"],
                                            doc["uid"],
                                            widget.uuis.toString())));
                              },
                              horizontalTitleGap: 20,
                              leading: Stack(children: [
                                CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(doc["image"].toString()),
                                    radius: 35),
                                Positioned(
                                  child: CircleAvatar(
                                    backgroundColor: (doc["online"] == 1)
                                        ? Color.fromARGB(255, 31, 222, 31)
                                        : Color.fromARGB(255, 249, 4, 4),
                                    radius: 6,
                                  ),
                                  left: 10,
                                  top: 1,
                                )
                              ]),
                              title: Text(doc['Name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text("sending...."),
                            ),
                          );
                        }).toList(),
                        // children: documents
                        //     .map((doc) => Padding(
                        //           padding: const EdgeInsets.all(10.0),
                        //           child: Card(
                        //             child: ListTile(
                        //               onTap: () {
                        //                 Navigator.of(context).push(
                        //                     new MaterialPageRoute(
                        //                         builder: (ctx) => screeen()));
                        //               },
                        //               horizontalTitleGap: 20,
                        //               leading: CircleAvatar(
                        //                   backgroundImage:
                        //                       NetworkImage(doc["image"].toString()),
                        //                   radius: 25),
                        //               title: Text(doc['Name']),
                        //               subtitle: Text("sending...."),
                        //             ),
                        //           ),
                        //         ))
                        // .toList()
                      );
                    }
                  }),
                  stream: FirebaseFirestore.instance
                      .collection("contacts")
                      .snapshots(),
                ),
              ),
            ),
            Container(),
          ],
        ));
  }
}

class appsdrawer extends StatelessWidget {
  const appsdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer();
  }
}
