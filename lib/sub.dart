// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:warehouse/welcome.dart';

// // class Application extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _Application();
// // }

// // class _Application extends State<Application> {
// //   late String _token;

// //   Future<void> setupToken() async {
// //     await Firebase.initializeApp();
// //     // Get the token each time the application loads
// //     String? token = await FirebaseMessaging.instance.getToken();

// //     print(token);
// //   }

// //   @override
// //   void initState() {
// //     super.initState();

// //     setupToken();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Text("...");
// //   }
// // }

// class testsign extends StatefulWidget {
//   testsign({Key? key}) : super(key: key);

//   @override
//   State<testsign> createState() => _testsignState();
// }

// class _testsignState extends State<testsign> {
//   bool loggin = false;
//   late GoogleSignInAccount acc;
//   Color s = Colors.lightGreen;
//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     // Optional clientId
//     // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//     scopes: <String>[
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );
//   Future<void> out() async {
//     await _googleSignIn.signOut();
//     setState(() {
//       s = Colors.lightGreen;
//     });
//   }

//   Future<GoogleSignInAccount?> teest() async {
//     try {
//       // ignore: unused_local_variable
//       GoogleSignInAccount? acc =
//           await _googleSignIn.signIn().catchError((e) {});
//       loggin = true;
//       print(acc?.email.toString());
//       String? token = await FirebaseMessaging.instance.getToken();
//       print(token);
//       setState(() {
//         s = Colors.amber;
//       });
//       return acc;
//     } catch (e) {
//       print('yes');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: s,
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   var ss = await teest();
//                   print("reached");
//                   print(ss?.displayName.toString());
//                   Navigator.of(context).pushReplacement(
//                       new MaterialPageRoute(builder: (ctx) => welcoming()));
//                 },
//                 child: Text("siging..")),
//             ElevatedButton(
//                 onPressed: () {
//                   out();
//                 },
//                 child: Text("out..")),
//           ],
//         ),
//       ),
//     );
//   }
// }
