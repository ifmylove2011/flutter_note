import 'package:flutter/material.dart';

Divider d1 = const Divider(
  color: Colors.green,
  thickness: 1,
  height: 5,
);

BoxDecoration bd1 = BoxDecoration(
    gradient: LinearGradient(colors: [
      const Color.fromARGB(255, 215, 217, 218),
      Colors.green.shade100
    ]),
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
        blurRadius: 4,
        color: Colors.black45,
        offset: Offset(2, 2),
      )
    ]);
