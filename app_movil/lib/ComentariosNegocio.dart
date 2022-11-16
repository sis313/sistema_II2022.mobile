

import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DTO/Comment.dart';

class ComentariosNegocio extends StatefulWidget {
  final int id;

  const ComentariosNegocio( this.id);
  @override
  State<ComentariosNegocio> createState() => _ComentariosNegocioState();
}

class _ComentariosNegocioState extends State<ComentariosNegocio> {
  TextEditingController _textFieldController = TextEditingController();
  Future<List<Comment>> comments;
  var id;
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nuevo comentario'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Entrar comentario"),
            ),
            actions: [
              new ElevatedButton(
                child: new Text('Guardar'), style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
          )),
                onPressed: () {
                  Navigator.of(context).pop();
                },

              )
            ],
          );
        });
  }

  Widget miCard(List<Comment> comment, BuildContext context) {
    print("------------------------!!!");
    print(comment.length);
    print(comment.toString());
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: comment

            .map(

                (e) =>
          Column(

            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: Text(e.id.toString()),
                subtitle: Text(
                    e.message.toString()),
                leading: Icon(Icons.account_box_outlined),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(onPressed: () => {}, child: Icon(Icons.edit) ,
                      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xff85cbcc)),
                      )),
                  ElevatedButton(onPressed: () => {}, child: Icon(Icons.delete),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xffe72b3e)),
                      )
                  ),
                ],
              )
            ],
          )).toList()

        )

    );
  }

  @override
  Widget build(BuildContext context) {
    comments = Provider.of<BoActiveProvider>(context, listen: false).getComentById(widget.id) ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios del negocio'),
        backgroundColor: Color(0xffa7d676),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(future:comments,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return miCard(snapshot.data, context);
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
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              elevation: 50.0,
              backgroundColor: Color(0xfffbc78d),
              onPressed: () => _displayDialog(context),
            ),
          ],

        ),
      ),

    );
  }
}
