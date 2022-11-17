import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

import 'ClienteServicios.dart';
import 'DTO/Rating.dart';
import 'MenuLateral.dart';


void main() => runApp(Favoritos());


class Favoritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: RandWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandWords extends StatefulWidget {
  @override
  RandWordsState createState() => RandWordsState();
}

class RandWordsState extends State<RandWords> {
  final _randomWordPairs = <WordPair>[];
  final _addWordPairs = Set<WordPair>();

  Future<List<Rating>> myRating;

/*
  Widget anadirFav(){
    return FutureBuilder(
      future: myRating,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return _buildList(snapshot.data);
        }
        else if (snapshot.data == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }*/
  /*
  Widget _buildList(List<Rating> myRating) {

    return ListView.builder(

      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {

        if (item.isEven) return Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }*/


  Widget _buildList() {
    return ListView.builder(

      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {

        if (item.isEven) return Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }


  Widget _buildRow(WordPair pair) {
    final alreadyadd = _addWordPairs.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadyadd ? Icons.star_rate : Icons.star,
            color: alreadyadd ? null : Color(0xfff6dd34)),
        onTap: () {
          setState(() {
            if (alreadyadd) {
              _addWordPairs.remove(pair);
            } else {
              _addWordPairs.add(pair);
            }
          });
        });
  }

  void _pushadd() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) {
    final Iterable<ListTile> tiles = _addWordPairs.map((WordPair pair) {
      return ListTile(
          title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
    });
    myRating = Provider.of<BoActiveProvider>(context, listen: false).getRanting();
    final List<Widget> divided =
    ListTile.divideTiles(context: context, tiles: tiles).toList();


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xffa7d676),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClienteServicios()));
            },
          ),

        ),
        body: ListView(children: divided));
  }));


  Widget build(BuildContext context) => Scaffold(
      drawer: MenuLateral(),
      appBar: AppBar(title: Text("Mis Favoritos"),
          backgroundColor: Color(0xffa7d676) ),
      body: _buildList());
}