import 'package:flutter/material.dart';
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
            child: Text.rich(
              TextSpan(
                children: <TextSpan> [
                  TextSpan(text: "Bienvenido a ", style: TextStyle(fontSize: 30)),
                  TextSpan(text: "BoaActive", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xffa7d676))),
                  TextSpan(text: "!", style: TextStyle(fontSize: 30)),
                ]
              )
            ),
          ),

          SizedBox(
            height: 50,
          ),

          Center(
            child: Container(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage('assets/Logo_BOActive.png'),
                )
            ),
          ),

          SizedBox(
            height: 50,
          ),

          Container(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Inicia sesión',
                style: TextStyle(color: Color(0xffffffff), fontSize: 15),
              ),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
    ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color(0xffa7d676))
            )
        )),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          Container(
            width: 250,
            child: ElevatedButton(

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RoleMenu()));
                },
                child: Text(
                  'Regístrate',
                  style: TextStyle(color: Color(0xffffffff), fontSize: 15),

                ),

                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xfffbc78d)
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xfffbc78d))
                        )
                    )),
            ),
          ),

        ],
      ),
    );
  }
}