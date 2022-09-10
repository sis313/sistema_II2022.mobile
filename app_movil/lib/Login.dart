import 'dart:html';

import 'package:app_movil/RoleMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate(){
    if(formkey.currentState.validate()){
      print("Validated");
    }else{
      print("NOT Validated");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xfff3ede0),
      body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.7,
                      0.8,
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
              Center(
                child: Text(
                  'SAF',
                  style: new TextStyle(
                    fontSize: 80,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Form(
                  key: formkey,
                  autovalidate: true,
                  child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextFormField(
                        validator: MultiValidator([
                          EmailValidator(errorText: "correo invalido"),
                          RequiredValidator(errorText: "campo requerido")
                        ]
                        ),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff6B7A40), width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff745D20), width: 2.0),
                            ),
                            labelText: 'Correo',
                            //hintText: 'Ingresa un correo valido como abc@gmail.com'
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child:  TextFormField(
                          validator: MultiValidator([
                              RequiredValidator(errorText: "campo requerido"),
                              MinLengthValidator(8, errorText: "Minimo 8 caracteres")
                            ]
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff6B7A40), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff745D20), width: 2.0),
                              ),
                              labelText: 'Contraseña',
                              //hintText: 'minimo 8 caracteres'
                          ),
                        )
                    )

                  ],
                )
                )
              ),
              Container(
                padding: EdgeInsets.only(top: 30, right: 15, bottom: 30),
                child:Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      //TODO FORGOT PASSWORD SCREEN GOES HERE
                    },
                    child: Text(
                      'Olvidaste tu contraseña',
                      style: TextStyle(color: Color(0xff6B7A40), fontSize: 15),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Color(0xff6B7A40), borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: validate,
                  child: Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              Text('Aún no tienes una cuenta?'),
              FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RoleMenu()));
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Color(0xfff3ede0), fontSize: 15),
                ),
              ),
            ],
          ),
        ),
    );
  }
}