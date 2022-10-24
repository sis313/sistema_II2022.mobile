import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'RoleMenu.dart';

class StartMenu extends StatefulWidget {
  @override
  _StartMenu createState() => _StartMenu();
}

class _StartMenu extends State<StartMenu> {
  double buttonWidth = 250;

  @override
  Widget build(BuildContext context) {
    final elevButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.black,
      padding: EdgeInsets.all(10),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(text: "Bienvenido a ", style: TextStyle(fontSize: 30)),
              TextSpan(
                  text: "Mip",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.orange)),
              TextSpan(text: "!", style: TextStyle(fontSize: 30)),
            ])),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage('assets/icono.png'),
                )),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 250,
            child: ElevatedButton(
              style: elevButtonStyle,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Inicia sesión',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 250,
            child: ElevatedButton(
              style: elevButtonStyle,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RoleMenu()));
              },
              child: Text(
                'Regístrate',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("==============================");
          print("Calling provider...");
          Provider.of<BoActiveProvider>(context, listen: false).getCity();
          //Provider.of<BoActiveProvider>(context, listen: false).getComent();
          //Provider.of<BoActiveProvider>(context, listen: false).getMunicipio();
          // print("==============================");
          // print("Calling provider...");
          // Provider.of<BoActiveProvider>(context, listen: false).getRanting();
          // Provider.of<BoActiveProvider>(context, listen: false).getByIDMunicipio(2);
        },
        child: Icon(Icons.account_tree_sharp),
      ),
    );
  }
}
