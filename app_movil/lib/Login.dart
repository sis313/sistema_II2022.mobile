import 'package:app_movil/Inicio.dart';

import 'package:app_movil/SignUp.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import 'Mapa.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nickname = new TextEditingController();
  TextEditingController password = new TextEditingController();
  void validate() {
    if (formkey.currentState.validate()) {
      print("Validated");
    } else {
      print("NOT Validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    final elevButtonStyle = ElevatedButton.styleFrom(
      primary: Color(0xffa7d676),

      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      elevation: 10,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );

    return Scaffold(
      //backgroundColor: Color(0xfff3ede0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffa7d676),Color(0xff85cbcc)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36.0, horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Iniciar Sesi??n",
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 42.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Es bueno verte de nuevo!",
                          style: TextStyle(
                            color: Color(0xfff3ede0),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: formkey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller:nickname ,
                                  validator: MultiValidator([

                                    RequiredValidator(
                                        errorText: "campo requerido")
                                  ]),

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffffffff),
                                    hintText: "Nickname",
                                    prefixIcon: Icon(
                                      Icons.supervised_user_circle,
                                      color: Colors.grey[600],
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffa7d676),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffa7d676),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller:password ,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "campo requerido"),
                                    MinLengthValidator(8,
                                        errorText: "Minimo 8 caracteres")
                                  ]),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffffffff),
                                    hintText: "Contrese??a",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey[600],
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffa7d676),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffa7d676),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                /*
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Olvidaste tu contrase??a",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Colors.amber,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                     */
                                SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  child: ElevatedButton(
                                    style: elevButtonStyle,
                                    onPressed: () async {
                                      validate;
                                      bool correct = await Provider.of<BoActiveProvider>(context, listen: false).login(
                                        nickname.text,
                                        password.text,
                                      );
                                      if(correct) Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                                      else _badLogin(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        "Ingresar",
                                        style: TextStyle(
                                          color: Color(0xfff3ede0),
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("A??n no tienes una cuenta?"),
                                      GestureDetector(
                                        child: const Text(" Registrate ahora",
                                            style: TextStyle(
                                                color: Color(0xfffbc78d),
                                                decoration:
                                                    TextDecoration.underline)),
                                        onTap: () async {
                                          try {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUp()));
                                          } catch (err) {
                                            debugPrint(
                                                'Something bad happened');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        )),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  _badLogin(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text("Credenciales inv??lidas, intenta nuevamente"),
            actions: [
              new ElevatedButton(
                child: new Text('OK'), style: ButtonStyle(
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
}
