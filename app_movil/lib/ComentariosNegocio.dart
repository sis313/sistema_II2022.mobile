import 'package:flutter/material.dart';



class ComentariosNegocio extends StatefulWidget {
  ComentariosNegocio({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ComentariosNegocio createState() => _ComentariosNegocio();
}

class _ComentariosNegocio extends State<ComentariosNegocio> {
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Comentarios'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Comentario"),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red,
                  textStyle:  TextStyle( color: Colors.white),),

                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green,
                  textStyle:  TextStyle( color: Colors.white),),

                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }

  String codeDialog;
  String valueText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (codeDialog == "123456") ? Colors.green : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Alert Dialog'),
      ),
      body: Center(
        
        child: Column(
          children: [
        ListView.builder(

        //itemCount: items.length,
          itemBuilder: (context, index) {

              return ListTile(
                title: Text('User'),
                subtitle: Text('comentario'),

              );

            },
        ),
            ElevatedButton.icon( icon: Icon(Icons.edit), onPressed: () {

            },),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary:  Colors.teal,
                textStyle:  TextStyle( color: Colors.white),),
              onPressed: () {
                _displayTextInputDialog(context);
              },
              child: Text('Press For Alert'),
            ),
          ],
        ),
      ),
    );
  }
}