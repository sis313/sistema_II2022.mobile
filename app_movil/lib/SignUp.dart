import 'package:app_movil/Login.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
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
      body: Container(
        decoration: BoxDecoration(
          /*
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

           */
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'Nuevo usuario',
                    style: new TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffa7d676)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Bienvenido a nuestra familia!"),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child:Form(
                      autovalidateMode: AutovalidateMode.always, key: formkey,
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              child: TextFormField(
                                validator: MultiValidator([
                                  EmailValidator(errorText: "correo invalido"),
                                  RequiredValidator(errorText: "campo requerido")
                                ]),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xfffbc78d), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xfffbc78d), width: 2.0),
                                    ),
                                    labelText: 'Correo',
                                    hintText: 'Ingresa un direccion valida'
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "campo requerido"),
                                  MinLengthValidator(8, errorText: "Minimo 8 caracteres")
                                ]
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xfffbc78d), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:Color(0xfffbc78d), width: 2.0),
                                    ),
                                    labelText: 'Contraseña',
                                    hintText: 'Minimo 8 caracteres'
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 15, bottom: 0),
                              //padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "campo requerido"),
                                  MinLengthValidator(8, errorText: "Minimo 8 caracteres")
                                ]
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xfffbc78d), width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xfffbc78d), width: 2.0),
                                  ),
                                  labelText: 'Confirmar contraseña',
                                  //hintText: 'Enter secure password'
                                ),
                              ),
                            )
                          ]
                      )
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xfffbc78d)
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xfffbc78d))
                            )
                        )),
                      onPressed: validate,
                      child: Text(
                        'Registrar',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),

                  ),
                ),

                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ya tienes una cuenta?"),
                    GestureDetector(
                      child: const Text(" Iniciar sesión",
                          style: TextStyle(
                              color: Color(0xff85cbcc), decoration: TextDecoration.underline)
                      ),
                      onTap: () async {
                        try {
                          await  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        } catch (err) {
                          debugPrint('Something bad happened');
                        }
                      },
                    )

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}