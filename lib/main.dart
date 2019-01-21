import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "第一个",
        theme: new ThemeData(
          primaryColor: Colors.grey,
        ),
        home: new RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final words = <WordPair>[];
  final font = const TextStyle(fontSize: 18);
  final favorite = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("试试"),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: pushFavorite)
        ],
      ),
      body: buildWords(),
    );
  }

  void pushFavorite() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = favorite.map((wordPair) {
        return new ListTile(
          title: new Text(
            wordPair.asPascalCase,
            style: font,
          ),
        );
      });
      final marked =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("试一下"),
        ),
        body: new ListView(
          children: marked,
        ),
      );
    }));
  }

  Widget buildWords() {
    return new ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd)
        return new Divider(
          color: Colors.amber,
        );
      final index = i ~/ 2;
      if (index >= words.length) {
        words.addAll(generateWordPairs().take(10));
      }
      return buildRow(index, words[index]);
    });
  }

  Widget buildRow(int index, WordPair wordPair) {
    final saved = favorite.contains(wordPair);
    return new ListTile(
        title: new Text(
          wordPair.asPascalCase,
          style: font,
        ),
        leading: new Text("$index"),
        trailing: new Icon(
          saved ? Icons.favorite : Icons.favorite_border,
          color: saved ? Colors.red : Colors.grey,
        ),
        onTap: () {
          setState(() {
            if (saved) {
              favorite.remove(wordPair);
            } else {
              favorite.add(wordPair);
            }
          });
        });
  }
}
