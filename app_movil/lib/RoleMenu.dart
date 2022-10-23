import 'package:app_movil/OwnerMenu.dart';
import 'package:app_movil/SignUp.dart';
import 'package:flutter/material.dart';

class RoleMenu extends StatefulWidget {
  @override
  _RoleMenu createState() => _RoleMenu();
}

class _RoleMenu extends State<RoleMenu> {
  @override
  Widget build(BuildContext context) {

    final elevButtonStyle = ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.all(10),
    );

    return Scaffold(
        //backgroundColor: Color(0xfff3ede0),
        body:Container(
          /*
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

           */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Registro',
                style: new TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffa7d676)
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Quiero registrarme como...',
                style: new TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
              child: Container(
                width: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xfff9e2ae)
              ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xfff9e2ae))
                    )
                )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Cliente',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
              ),
              ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff85cbcc)
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff85cbcc))
                        )
                    )),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OwnerMenu()));
                  },
                  child: Text(
                    'Negocio',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
            ),
          ],
        )
      )
    );
  }
}