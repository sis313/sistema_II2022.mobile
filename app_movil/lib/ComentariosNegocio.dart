import 'package:flutter/material.dart';

class ComentariosNegocio extends StatefulWidget {
  @override
  State<ComentariosNegocio> createState() => _ComentariosNegocioState();
}

class _ComentariosNegocioState extends State<ComentariosNegocio> {
  TextEditingController _textFieldController = TextEditingController();

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
                child: new Text('Enviar'),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(onPressed: () => {}, child: Icon(Icons.edit)),
              ElevatedButton(onPressed: () => {}, child: Icon(Icons.delete)),
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
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            miCard(),
            FloatingActionButton(
              child: Icon(Icons.add),
              elevation: 50.0,
              backgroundColor: Color(0xffCEA660),
              onPressed: () => _displayDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
