import 'dart:ffi';

import 'package:flutter/material.dart';

class bubble extends StatelessWidget {
  String msg = "";
  bool me = false;
  bubble(String msg, bool me) {
    this.msg = msg;
    this.me = me;
    // this.me = true;
  }

  @override
  Widget build(BuildContext context) {
    print(msg);
    print(me);
    return Row(
      mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 250,
          decoration: me? const BoxDecoration(
              color: Color.fromARGB(255, 245, 227, 227),
              boxShadow: [BoxShadow(offset: Offset.infinite)],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14))) : const BoxDecoration(
              color: Color.fromARGB(255, 228, 222, 222),
              boxShadow: [BoxShadow(offset: Offset.infinite)],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              msg,
              style: TextStyle(fontSize: 17),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
        ),
      ],
    );
  }
}
