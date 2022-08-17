import 'package:flutter/material.dart';
import 'package:flutter_note/generated/l10n.dart';
import 'package:flutter_note/widgets/function_w.dart';

class GridMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      children: [
        MenuCard(
            icon: Icons.note, text: S.current.literal_note, tapFunc: () {}),
        MenuCard(
            icon: Icons.audio_file, text: S.current.audio_note, tapFunc: () {}),
        MenuCard(
            icon: Icons.article,
            text: S.current.hyper_note,
            tapFunc: () {
              print("hee ...");
            }),
        MenuCard(
            icon: Icons.audiotrack, text: S.current.recording, tapFunc: () {}),
        MenuCard(icon: Icons.camera, text: S.current.camera, tapFunc: () {}),
        MenuCard(icon: Icons.alarm, text: S.current.alarm, tapFunc: () {}),
        MenuCard(
            icon: Icons.attach_file, text: S.current.attach, tapFunc: () {}),
        MenuCard(
            icon: Icons.bookmark, text: S.current.bookmark, tapFunc: () {}),
        MenuCard(
            icon: Icons.favorite, text: S.current.favorite, tapFunc: () {}),
        MenuCard(
            icon: Icons.category, text: S.current.category, tapFunc: () {}),
      ],
    );
  }
}
