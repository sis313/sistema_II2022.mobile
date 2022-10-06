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
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6B7A40), Color(0xffCEA660)],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
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
                                      onPressed: (){
                                        validate;
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => ClienteServicios()));
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
