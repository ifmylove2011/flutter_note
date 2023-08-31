import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note/common/constant.dart';
import 'package:flutter_note/common/model/django/note.dart';
import 'package:flutter_note/common/net/note_service.dart';
import 'package:flutter_note/common/util/str_util.dart';
import 'package:flutter_note/widgets/derate.dart';
import 'package:flutter_note/widgets/function_w.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key, required this.layout}) : super(key: key);

  final Layout layout;

  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List<Note> notes = [];
  int currentIndex = 0;
  bool loading = false;

  @override
  void initState() {
    loading = true;
    requestNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.layout == Layout.grid || widget.layout == Layout.monsonry) {
      if (Platform.isAndroid) {
        //处理因SliveApp存在ListView或GridView无法感知头部高度的问题
        return LoadingOverlay(
            isLoading: loading,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverMasonryGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _item(index);
                      },
                    ),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    )),
              ],
            ));
      }
      return LoadingOverlay(
        isLoading: loading,
        child: MasonryGridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _item(index);
          },
        ),
      );
    } else {
      if (Platform.isAndroid) {
        //处理因SliveApp存在ListView或GridView无法感知头部高度的问题
        return LoadingOverlay(
            isLoading: loading,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _item(index);
                  },
                ))
              ],
            ));
      }
      return LoadingOverlay(
          isLoading: loading,
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _item(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return d1;
              },
              itemCount: notes.length));
    }
  }

  Widget _item(int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: DecoratedBox(
          decoration: bd1,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.start,
                    notes[index].title!.trimLeft(),
                    textScaleFactor: 1.5,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    StrUtil.trimAbstract(notes[index].content!),
                    textScaleFactor: 1,
                  ),
                  Text(
                    style: const TextStyle(color: Colors.black54),
                    textAlign: TextAlign.start,
                    notes[index].lastViewTime == null
                        ? notes[index].createTime!
                        : notes[index].lastViewTime!,
                    textScaleFactor: 0.8,
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteNames.NOTE_DETAIL,
                      arguments: notes[index])
                  .then((value) {
                debugPrint("--------$value");
              });
            },
          )),
    );
  }

  void requestNote() {
    Future(() async {
      return await NoteService.getAllNoteLocal();
    }).then((value) {
      notes = value!;
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      debugPrint(error);
    });
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   setState(() {
    //     words.insertAll(
    //       0,
    //       generateWordPairs().take(10).map((e) => e.asPascalCase).toList(),
    //     );
    //   });
    // });
  }
}
