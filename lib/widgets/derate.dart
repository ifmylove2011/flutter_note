import 'package:flutter/material.dart';

Divider d1 = const Divider(
  color: Colors.black12,
  thickness: 0.5,
  height: 2,
);

BoxDecoration bd1 = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.white, Colors.green.shade100]),
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
        blurRadius: 4,
        color: Colors.black45,
        offset: Offset(2, 2),
      )
    ]);

BoxDecoration bd2 = BoxDecoration(
    border: Border.all(color: Colors.black54, width: 0.5),
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
        blurRadius: 4,
        color: Colors.lightGreen,
        offset: Offset(-1, -1),
      ),
      BoxShadow(
        blurRadius: 4,
        color: Colors.white,
      ),
    ]);

BoxDecoration bd3 = BoxDecoration(
    gradient: LinearGradient(colors: [
      Colors.green.shade100,
      Colors.white,
    ]),
    // border: Border.all(color: Colors.lightBlue, width: 0.5),
    borderRadius: BorderRadius.circular(5),
    boxShadow: const [
      BoxShadow(
        blurRadius: 4,
        color: Colors.white,
        offset: Offset(2, 2),
      )
    ]);
// Widget card(IconData icon, String text, GestureTapCallback? tapFunc) {
//   return InkWell(
//     child: Container(
//       // constraints: BoxConstraints(maxHeight: 200,maxWidth: 200),
//       margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//       decoration: bd2,
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Icon(icon, color: Colors.lightGreen),
//         Padding(
//           padding: EdgeInsets.only(top: 5.0),
//           child: Text(text),
//         )
//       ]),
//     ),
//     onTap: tapFunc,
//   );
// }

// Widget skimCard() {
//   return InkWell();
// }
