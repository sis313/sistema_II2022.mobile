import 'package:app_movil/Inicio.dart';
import 'package:app_movil/RoleMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'Mapa.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
      primary: Colors.orange,
      onPrimary: Color(0xfff3ede0),
      shadowColor: Color(0xffCEA660),
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
              colors: [Colors.orange, Colors.amber],
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
                          "Iniciar Sesión",
                          style: TextStyle(
                            color: Color(0xfff3ede0),
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
                            color: Color(0xfff3ede0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: formkey,
                            child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      validator: MultiValidator([
                                        EmailValidator(errorText: "correo invalido"),
                                        RequiredValidator(
                                            errorText: "campo requerido")
                                      ]),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xfff3ede0),
                                        hintText: "Correo",
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.grey[600],
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent, width: 2.0),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent, width: 2.0),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "campo requerido"),
                                        MinLengthValidator(8,
                                            errorText: "Minimo 8 caracteres")
                                      ]),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xfff3ede0),
                                        hintText: "Contreseña",
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.grey[600],
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent, width: 2.0),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent, width: 2.0),
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
                                          "Olvidaste tu contraseña",
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
                                        onPressed: (){
                                          validate;
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => Home()));
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
                                          Text("Aún no tienes una cuenta?"),
                                          GestureDetector(
                                            child: const Text(" Registrate ahora",
                                                style: TextStyle(
                                                    color: Colors.orange, decoration: TextDecoration.underline)
                                            ),
                                            onTap: () async {
                                              try {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RoleMenu()));
                                              } catch (err) {
                                                debugPrint('Something bad happened');
                                              }
                                            },
                                          )

                                        ],
                                      ),
                                    )
<<<<<<< HEAD

                              ]),
                        )
                    ),
                  ),
                )
              ]),
        ),
=======
                                  ],
                                ),
                              )
                            ]),
                      )),
                ),
              )
            ]),
>>>>>>> a144c7f8c2d5f8fc9bdb4db0041b3ea9629e05b1
      ),
    );
  }
}
