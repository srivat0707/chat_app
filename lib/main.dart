// import 'package:flutter/material.dart';
// import 'package:warehouse/forming.dart';
// import 'package:warehouse/sub.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           // Center is a layout widget. It takes a single child and positions it
//           // in the middle of the parent.
//           child: Column(
//             // Column is also a layout widget. It takes a list of children and
//             // arranges them vertically. By default, it sizes itself to fit its
//             // children horizontally, and tries to be as tall as its parent.
//             //
//             // Invoke "debug painting" (press "p" in the console, choose the
//             // "Toggle Debug Paint" action from the Flutter Inspector in Android
//             // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//             // to see the wireframe for each widget.
//             //
//             // Column has various properties to control how it sizes itself and
//             // how it positions its children. Here we use mainAxisAlignment to
//             // center the children vertically; the main axis here is the vertical
//             // axis because Columns are vertical (the cross axis would be
//             // horizontal).
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'You have pushed the button this many times:',
//               ),
//               Text(
//                 '$_counter',
//                 style: Theme.of(context).textTheme.headline4,
//               ),
//               Application(),
//               workingwithform(),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/custom.dart';
import 'package:warehouse/forming.dart';
import 'package:warehouse/sub.dart';
import 'package:warehouse/welcome.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   print(message.data);
//   flutterLocalNotificationsPlugin.show(
//       message.data.hashCode,
//       message.data['title'],
//       message.data['body'],
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//         ),
//       ));
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   description: 'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
    // print("calling from main");
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');
    // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    //   'Flutter chat demo',
    //   'your channel description',
    //   playSound: true,
    //   enableVibration: true,
    //   priority: Priority.high,
    // );
    // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    // print("i am called");
    // var platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    // if (message.notification != null) {
    //   print(
    //       'Message also contained a notification: ${message.notification?.title}');
    //   await FlutterLocalNotificationsPlugin().show(
    //     0,
    //     message.notification?.title.toString(),
    //     message.notification?.body.toString(),
    //     platformChannelSpecifics,
    //   );
    // }
  
  await Firebase.initializeApp();
  bool s2 = false;
  print("yes");
  final prefs = await SharedPreferences
      .getInstance(); // Save an String value to 'action' key.
  String? s = await prefs.getString('useraction');
  if (s != null) {
    s2 = true;
  }
  print(s2);
  print(s);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Sign In',
      home: s2 ? welcoming(s) : workingwithform(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  // GoogleSignInAccount? _currentUser;
  // String _contactText = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
  //     setState(() {
  //       _currentUser = account;
  //     });
  //     if (_currentUser != null) {
  //       _handleGetContact(_currentUser!);
  //     }
  //   });
  //   _googleSignIn.signInSilently();
  // }

  // Future<void> _handleGetContact(GoogleSignInAccount user) async {
  //   setState(() {
  //     _contactText = 'Loading contact info...';
  //   });
  //   final http.Response response = await http.get(
  //     Uri.parse('https://people.googleapis.com/v1/people/me/connections'
  //         '?requestMask.includeField=person.names'),
  //     headers: await user.authHeaders,
  //   );
  //   if (response.statusCode != 200) {
  //     setState(() {
  //       _contactText = 'People API gave a ${response.statusCode} '
  //           'response. Check logs for details.';
  //     });
  //     print('People API ${response.statusCode} response: ${response.body}');
  //     return;
  //   }
  //   final Map<String, dynamic> data =
  //       json.decode(response.body) as Map<String, dynamic>;
  //   final String? namedContact = _pickFirstNamedContact(data);
  //   setState(() {
  //     if (namedContact != null) {
  //       _contactText = 'I see you know $namedContact!';
  //     } else {
  //       _contactText = 'No contacts to display.';
  //     }
  //   });
  // }

  // String? _pickFirstNamedContact(Map<String, dynamic> data) {
  //   final List<dynamic>? connections = data['connections'] as List<dynamic>?;
  //   final Map<String, dynamic>? contact = connections?.firstWhere(
  //     (dynamic contact) => contact['names'] != null,
  //     orElse: () => null,
  //   ) as Map<String, dynamic>?;
  //   if (contact != null) {
  //     final Map<String, dynamic>? name = contact['names'].firstWhere(
  //       (dynamic name) => name['displayName'] != null,
  //       orElse: () => null,
  //     ) as Map<String, dynamic>?;
  //     if (name != null) {
  //       return name['displayName'] as String?;
  //     }
  //   }
  //   return null;
  // }

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  // Widget _buildBody() {
  //   final GoogleSignInAccount? user = _currentUser;
  //   if (user != null) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         ListTile(
  //           leading: GoogleUserCircleAvatar(
  //             identity: user,
  //           ),
  //           title: Text(user.displayName ?? ''),
  //           subtitle: Text(user.email),
  //         ),
  //         const Text('Signed in successfully.'),
  //         Text(_contactText),
  //         ElevatedButton(
  //           child: const Text('SIGN OUT'),
  //           onPressed: _handleSignOut,
  //         ),
  //         ElevatedButton(
  //           child: const Text('REFRESH'),
  //           onPressed: () => _handleGetContact(user),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: <Widget>[
  //         const Text('You are not currently signed in.'),
  //         ElevatedButton(
  //           child: const Text('SIGN IN'),
  //           onPressed: _handleSignIn,
  //         ),
  //       ],
  //     );
  //   }
  // }
  bool s2 = false;
  Future<void> summa() async {
    print("yes");
    final prefs = await SharedPreferences
        .getInstance(); // Save an String value to 'action' key.
    String? s = await prefs.getString('useraction');
    if (s != "") {
      setState(() {
        s2 = true;
      });
      print("saved");
      print("s2=====");
      print(s2);
    }
  }

  @override
  void didChangeDependencies() async {
    print("calling summa");
    await summa();
    print("completed");
  }

  // void initState() {
  //   print("calling summa");
  //   summa();
  //   print("completed");
  // }

  @override
  Widget build(BuildContext context) {
    return workingwithform();
    //dsg
    // return bubble();
  }
}
