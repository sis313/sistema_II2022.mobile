import 'package:app_movil/ClienteServicios.dart';
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
        primary: Color(0xff6B7A40),
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
                    Container(
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
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  child:Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary:  Colors.transparent,
                          onPrimary: Color(0xfff3ede0),
                          shadowColor:  Colors.transparent,
                      ),
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
              ),

             Flexible(
                  child: Center(
                    child: ElevatedButton(
                      style: elevButtonStyle,
                      onPressed: validate,
                      child: Text(
                        'Ingresar',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),

              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color(0xff6B7A40), borderRadius: BorderRadius.circular(20)),
                  child:  Center(
                      child: ElevatedButton(
                        onPressed: (){
                          validate;
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => ClienteServicios()));
                        },
                        child: Text(
                          'Ingresar',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
              ),



              Text('Aún no tienes una cuenta?'),


              Flexible(
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:  Colors.transparent,
                    onPrimary: Color(0xfff3ede0),
                    shadowColor:  Colors.transparent,
                  ),

              child: Flexible(
                fit: FlexFit.tight,

                child:ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RoleMenu()));
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Color(0xfff3ede0), fontSize: 15),
                ),
              ),)))
            ],
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
                        "Servi LP",
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
                        "Inicio de sesión",
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
                          color: Color(0xfff3ede0).withOpacity(0.4),
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
                                            color: Color(0xff6B7A40), width: 2.0),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff745D20), width: 2.0),
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
                                            color: Color(0xff6B7A40), width: 2.0),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff745D20), width: 2.0),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Olvidaste tu contraseña",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Color(0xff6B7A40),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                  ),

                                  Container(
                                    child: ElevatedButton(
                                      style: elevButtonStyle,
                                      onPressed: validate,
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
                                  SizedBox(
                                    height: 80.0,
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
                                                  color: Color(0xff6B7A40), decoration: TextDecoration.underline)
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
                                ]),
                          )
                      ),
                    ),
                  )
            ]),
      ),
    );
  }
}
