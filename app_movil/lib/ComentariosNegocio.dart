import 'package:flutter/material.dart';

class ComentariosNegocio extends StatefulWidget {
  @override
  State<ComentariosNegocio> createState() => _ComentariosNegocioState();
}

class _ComentariosNegocioState extends State<ComentariosNegocio> {
  TextEditingController _textFieldController = TextEditingController();
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

  Card miCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Titulo'),
            subtitle: Text(
                'Este es el subtitulo del card. Aqui podemos colocar descripción de este card.'),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios del negocio'),
        backgroundColor: Color(0xffa7d676),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            miCard(),
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
