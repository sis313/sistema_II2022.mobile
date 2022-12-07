import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DTO/Comment.dart';

class ComentariosNegocio extends StatefulWidget {
  final int id;

  const ComentariosNegocio(this.id);
  @override
  State<ComentariosNegocio> createState() => _ComentariosNegocioState();
}

class _ComentariosNegocioState extends State<ComentariosNegocio> {

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController1 = TextEditingController();
  Future<List<Comment>> comments;
  var id;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    comments = Provider.of<BoActiveProvider>(context, listen: false).getCommentbyid(widget.id);
    print(comments);
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios del negocio'),
        backgroundColor: Color(0xffa7d676),
      ),
      body: Center(
        child: FutureBuilder(

          future:comments,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 50.0,
        backgroundColor: Color(0xfffbc78d),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nuevo comentario'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Ingresar comentario"),
            ),
            actions: [
              new ElevatedButton(
                child: new Text('Guardar'), style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
                  )),
                onPressed: () {
                  var response = Provider.of<BoActiveProvider>(context, listen: false).createComment(_textFieldController.text, 1, widget.id);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  _update(BuildContext context, int id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Actualizar comentario'),
            content: TextField(
              controller: _textFieldController1,

              decoration: InputDecoration(hintText: "Actualizar comentario"),
            ),
            actions: [
              new ElevatedButton(
                child: new Text('Guardar'), style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
                  )),
                onPressed: () {
                  var response = Provider.of<BoActiveProvider>(context, listen: false).updateComment(id, _textFieldController1.text, 1, widget.id);
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
    return SingleChildScrollView(
      child: Card(
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
                            title: Text(e.message.toString()),
                            subtitle: Text(
                                e.idComment.toString()),
                            leading: Icon(Icons.account_box_outlined),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton(onPressed: () => _update(context,e.idComment), child: Icon(Icons.edit) ,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xff85cbcc)),
                                  )),
                              ElevatedButton(onPressed: () {
                                setState(() {

                                  var response = Provider.of<BoActiveProvider>(context, listen: false).deleteComment(e.idComment);

                                });


                              }, child: Icon(Icons.delete),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xffe72b3e)),
                                  )
                              ),
                            ],
                          )
                        ],
                      )).toList()
          )
      ),
    );
  }

}
