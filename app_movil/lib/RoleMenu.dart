import 'package:app_movil/SignUp.dart';
import 'package:app_movil/StartMenu.dart';
import 'package:flutter/material.dart';

class RoleMenu extends StatefulWidget {
  @override
  _RoleMenu createState() => _RoleMenu();
}

class _RoleMenu extends State<RoleMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff3ede0),
        body:Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                  stops: [
                    0.4,
                    0.6,
                    1
                  ],
                  colors: [
                    Color(0xfff3ede0),
                    Color(0xffCEA660),
                    Color(0xff6B7A40)
                  ]
                )
              ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'SAF',
                  style: new TextStyle(
                    fontSize: 80,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/icono.png')),
              ),
            ),
            Center(
              child: Text(
                'Quiero registrarme como...',
                style: new TextStyle(
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xff6B7A40), borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  'Cliente',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xff6B7A40), borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  'Negocio',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color(0xff6B7A40), borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StartMenu()));
                },
                child: Text(
                  'Volver',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),


          ],
        )
      )
    );
  }
}