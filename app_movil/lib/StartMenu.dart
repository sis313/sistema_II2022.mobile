import 'package:flutter/material.dart';
import 'Login.dart';
import 'RoleMenu.dart';

class StartMenu extends StatefulWidget {
  @override
  _StartMenu createState() => _StartMenu();
}

class _StartMenu extends State<StartMenu> {
  @override
  //String color = HexColor.replaceAll('#', '0xff');
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xfff3ede0),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.4,
                0.7,
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
                      fontFamily: 'RobotoMono'
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Search and Find',
                  style: new TextStyle(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                       // color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image(
                      image: AssetImage('assets/icono.png'),
                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffCEA660),
                      border: Border.all(
                        color: Color(0xff745D20),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),

                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),

                ),
                SizedBox(
                  width: 20,
                  height: 130,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffCEA660),
                      border: Border.all(
                        color: Color(0xff745D20),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20)
                  ),

                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RoleMenu()));
                    },
                    child: Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),

                ),

              ],

            ),

          ],
        ),
      )
    );
  }
}