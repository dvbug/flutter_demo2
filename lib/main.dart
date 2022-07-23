import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.deepOrange,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home PageA'),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = <WordPair>{};
  final _biggerFont =
      const TextStyle(fontSize: 18, color: Colors.deepOrangeAccent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) {
          // 在 ListView 里的每一行之前，添加一个 1 像素高的分隔线 widget。
          return const Divider(height: 2,);
        }

        // 语法 i ~/ 2 表示 i 除以 2，但返回值是整型（向下取整），
        // 比如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2，这个可以计算出 ListView 中减去分隔线后的实际单词对数量。
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return _buildRow(_suggestions[index], index);
      },
    );
  }

  Widget _buildRow(WordPair pair, int index) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        subtitle: Text(index.toString()),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    var route = MaterialPageRoute<void>(
      builder: (BuildContext context) {

        final Iterable<ListTile> tiles = _saved.map(
          (WordPair pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
              onTap: () {
                print(_saved.length);
                print(pair);
                _saved.remove(pair);

              },
            );
          },
        );
        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        Scaffold scaffold = Scaffold(
          appBar: AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
        return scaffold;
      }
    );

    Navigator.of(context).push(route).then(onGoBack);
  }

  onGoBack(dynamic val) {
    setState(() {});
  }
}

// class FavoriteWidget extends StatefulWidget {
//   const FavoriteWidget({super.key});
//
//   @override
//   State<FavoriteWidget> createState() => _FavoriteWidgetState();
// }
//
// class _FavoriteWidgetState extends State<FavoriteWidget> {
//   bool _isFavorited = true;
//   int _favoriteCount = 41;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(0),
//           child: IconButton(
//             padding: const EdgeInsets.all(0),
//             alignment: Alignment.centerRight,
//             icon: (_isFavorited
//                 ? const Icon(Icons.star)
//                 : const Icon(Icons.star_border)),
//             color: Colors.red[500],
//             onPressed: _toggleFavorite,
//           ),
//         ),
//         SizedBox(
//           width: 18,
//           child: SizedBox(
//             child: Text('$_favoriteCount'),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _toggleFavorite() {
//     setState(() {
//       if (_isFavorited) {
//         _favoriteCount -= 1;
//         _isFavorited = false;
//       } else {
//         _favoriteCount += 1;
//         _isFavorited = true;
//       }
//     });
//   }
// }

// old

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
