import 'package:app_movil/BranchDetail.dart';
import 'package:app_movil/LoginEmpresa.dart';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

import 'DTO/Business.dart';
import 'DTO/Negocio.dart';
import 'DTO/Sucursal.dart';
import 'DTO/TypeBusiness.dart';
import 'servers/provider.dart';

class OwnerMenu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _OwnerMenuState();
}

class _OwnerMenuState extends State<OwnerMenu> {

  int idUser = 1;

  final controllerSucursal = TextEditingController();
  final ctrollerNegocioName = TextEditingController();
  final ctrollerNegocioDesc = TextEditingController();

  //Datos de ubicacion
  String zona = "";
  String municipio = "";
  String ciudad = "";

  //Hora de apertura
  TimeOfDay openTime = TimeOfDay.now();

  //Hora de apertura
  TimeOfDay closeTime = TimeOfDay.now();

  //Datos de prueba para dropdown
  //var vectorCategorias  = ['Categoria 1', 'Categoria 2', 'Categoria 3'];
  var vectorCategorias;
  int idcategoria = 0;

  //Valor que se mostrara al inicio en el dropdown menu
  String valueCategorias;

  //Valor que se mostrara al inicio en el dropdown menu
  String valueAtencion;

  //Datos de prueba para dropdown
  var vectorAtencion = ['Lunes a Viernes', 'Lunes a Sabado', 'Toda la semana'];

  //Datos de prueba para listado
  var negocios = [
    Negocio(1, 'Nombre Negocio 1', [Sucursal(1, 'Sucursal 1', ''), Sucursal(2, 'Sucursal 2', '')]),
    Negocio(2, 'Nombre Negocio 2', [Sucursal(3, 'Sucursal 1', '')]),
    Negocio(3, 'Nombre Negocio 3', [Sucursal(4, 'Sucursal 1', '')]),
    Negocio(4, 'Nombre Negocio 4', [Sucursal(5, 'Sucursal 1', '')]),
    Negocio(5, 'Nombre Negocio 5', [Sucursal(6, 'Sucursal 1', '')]),
    Negocio(6, 'Nombre Negocio 6', [Sucursal(7, 'Sucursal 1', '')]),
  ];

  // Provider vars
  Future<List<Business>> myList;
  Future<List<TypeBusiness>> tylist;

  @override
  void initState(){
    super.initState();
    vectorCategorias = Provider.of<BoActiveProvider>(context, listen: false).getTypeBusiness();
  }

  @override
  Widget build(BuildContext context) {
    myList = Provider.of<BoActiveProvider>(context, listen: false).getBusinessByUserId(1);
    tylist = Provider.of<BoActiveProvider>(context, listen: false).getTypeBusiness();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Mis Negocios'),
            backgroundColor: Color(0xffa7d676),
            elevation: 1,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginEmpresa()));
              },
            ),

            actions: [
              PopupMenuButton<int>(
                  onSelected: (item) => _onSelected(context, item),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      anadirNegocio()
                                    ],
                                  );
                                }
                            );
                          },
                          child: const Text('Añadir Negocio'),
                        )
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Salir'),
                    )
                  ]
              )
            ],
          ),
          body: FutureBuilder(
            future: myList,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return afterRequest(snapshot.data);
              }
              else if (snapshot.data == null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
      ),
    );
  }

  /*-------------------------------------*/
  /* WIDGET FUTURO LUEGO DE LA PETICION */
  /*-------------------------------------*/
  Widget afterRequest(List<Business> myList){
    return ListView.builder(
      padding: const EdgeInsets.all(17.0),
      itemCount: myList.length,
      itemBuilder: (context, index){
        /*return Card(
          child: Text("${myList[index].idTypeBusiness}")
        );*/
        /*if(myList[index].status != false)
          return Card();
        else*/
          return Card(
            child: businessCard(myList[index]),
          );
      },
    );
  }

  /*-------------------------------------*/
  /* WIDGET PARA EL LISTADO REFACTORED */
  /*-------------------------------------*/
  Widget businessCard (Business business){
    return GestureDetector(
      onHorizontalDragStart: (details){
        showDialog(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AlertDialog(
                    title: const Text('Estás seguro?'),
                    content: Column(
                      children: [
                        Text("Esta acción no puede deshacerse"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar',style: TextStyle(color: Colors.white, fontSize: 15)),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xffef5a68)
                            ),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Color(0xffef5a68))
                                )
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          var response = Provider.of<BoActiveProvider>(context, listen: false).
                            deleteBusinessById(business.idBusiness);
                          Navigator.pop(context);
                        },
                        child: const Text('Eliminar',style: TextStyle(color: Colors.white, fontSize: 15)),style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Color(0xffa7d676))
                              )
                          )),

                      ),
                    ],
                  )
                ],
              );
            }
        );
      },
      onLongPress: (){
        showDialog(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  editarNegocio(business)
                ],
              );
            }
        );
      },
      onTap: (){
        Route route = MaterialPageRoute(builder: (context) => BranchDetail(business.idBusiness));
        Navigator.push(context, route);
      },
      child: ListTile(
        leading: Icon(Icons.shop_2),
        title: Text(business.name, overflow: TextOverflow.ellipsis, maxLines: 1,),
      ),
    );
  }

/*-------------------------------------*/
  void _onSelected(BuildContext context, int item){
    switch(item){
      case 0:
        print('Seleccionado Añadir Negocio');
        break;

      case 1:
        print('Seleccionado Salir');
        break;
    }
  }

/*-------------------------------------*/
/*WIDGETS PARA FORMULARIOS*/
  Widget anadirNegocio(){
    return FutureBuilder(
      future: tylist,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return createForm(snapshot.data);
        }
        else if (snapshot.data == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget editarNegocio(Business business){
    return FutureBuilder(
      future: tylist,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return editForm(snapshot.data, business);
        }
        else if (snapshot.data == null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget editForm(List<TypeBusiness> tylist, Business business){
    GlobalKey<FormState> formkeyName = GlobalKey<FormState>();
    GlobalKey<FormState> formkeyDesc = GlobalKey<FormState>();

    ctrollerNegocioName.text = business.name;
    ctrollerNegocioDesc.text = business.description;

    return AlertDialog(
      title: const Text('Editar Negocio'),
      content: Form(
        child: Column(
          children: [
            Padding( padding: EdgeInsets.all(5)),
            TextFormField(
              controller: ctrollerNegocioName,
              autovalidateMode: AutovalidateMode.always,
              key: formkeyName,
              validator: MultiValidator([
                RequiredValidator( errorText: "Campo Requerido"),
              ]),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nombre de Negocio *',
              ),
            ),
            SizedBox(height: 10),
            Padding( padding: EdgeInsets.all(2)),
            TextFormField(
              controller: ctrollerNegocioDesc,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Descripcion',
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            FutureBuilder(
                future: vectorCategorias,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return DropdownButtonFormField<String>(
                        key: formkeyDesc,
                        validator: (value) => value == null?
                        'Campo requerido' : null,
                        value: valueCategorias,
                        items: snapshot.data.map<DropdownMenuItem<String>>(
                                (value) =>
                                DropdownMenuItem<String>(
                                  value: value.name.toString(),
                                  child: Text(value.name.toString()),
                                )).toList(),
                        onChanged: (value) {
                          setState(() {
                            this.valueCategorias = value;
                            List<TypeBusiness> lista = snapshot.data;
                            idcategoria = this._determinarNumero(this.valueCategorias, lista).id;
                            print("Resultado es " + this._determinarNumero(this.valueCategorias, lista).id.toString());
                          });
                        }
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffef5a68)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffef5a68))
                  )
              )
          ),
          onPressed: () { Navigator.pop(context);},
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        TextButton(
          onPressed: () {
            print("IdBusiness es ${business.idBusiness}");
            print("name es ${ctrollerNegocioName.text}");
            print("desc es ${ctrollerNegocioDesc.text}");
            print("idTypeBusiness es $idcategoria");
            print("idUser es $idUser");

            DateTime now = new DateTime.now();

            var response = Provider.of<BoActiveProvider>(context, listen: false).
            updateBusiness(
                business.idBusiness,
                ctrollerNegocioName.text,
                ctrollerNegocioDesc.text,
                idcategoria,
                idUser,
                now);

            /*Route route = MaterialPageRoute(builder: (context) => OwnerMenu());
            Navigator.push(context, route);*/

            //print("REsponse es " + response.toString());
          },
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xffa7d676))
                    )
                )),

            child: Text(
              'Registrar',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget createForm(List<TypeBusiness> tylist){    GlobalKey<FormState> formkeyName = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyDesc = GlobalKey<FormState>();
  return AlertDialog(
    title: const Text('Nuevo Negocio'),
    content: Form(
      child: Column(
        children: [
          Padding( padding: EdgeInsets.all(5)),
          TextFormField(
            controller: ctrollerNegocioName,
            autovalidateMode: AutovalidateMode.always,
            key: formkeyName,
            validator: MultiValidator([
              RequiredValidator( errorText: "Campo Requerido"),
            ]),
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nombre de Negocio *',
            ),
          ),
          SizedBox(height: 10),
          Padding( padding: EdgeInsets.all(2)),
          TextFormField(
            controller: ctrollerNegocioDesc,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Descripcion',
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          FutureBuilder(
              future: vectorCategorias,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return DropdownButtonFormField<String>(
                      key: formkeyDesc,
                      validator: (value) => value == null?
                      'Campo requerido' : null,
                      value: valueCategorias,
                      items: snapshot.data.map<DropdownMenuItem<String>>(
                              (value) =>
                              DropdownMenuItem<String>(
                                value: value.name.toString(),
                                child: Text(value.name.toString()),
                              )).toList(),
                      onChanged: (value) {
                        setState(() {
                          this.valueCategorias = value;
                          //print("Opcion es " + this.valueCategorias);
                          List<TypeBusiness> lista = snapshot.data;

                          idcategoria = this._determinarNumero(this.valueCategorias, lista).id;

                          print("Resultado es " + this._determinarNumero(this.valueCategorias, lista).id.toString());
                          //this._determinarNumero(this.valueCategorias, lista);
                        });
                      }
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          )
        ],
      ),
    ),
    actions: [
      ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffef5a68)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xffef5a68))
                )
            )
        ),
        onPressed: () { Navigator.pop(context);},
        child: Text(
          'Cancelar',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      TextButton(
        onPressed: () {
          //print(ctrollerNegocioName.text);
          //print(ctrollerNegocioDesc.text);
          //print(valueCategorias);
          //print(idcategoria);

          DateTime now = new DateTime.now();

          var response = Provider.of<BoActiveProvider>(context, listen: false).
          createBusiness(
              ctrollerNegocioName.text,
              ctrollerNegocioDesc.text,
              idcategoria,
              1,
              now,
              now);

          //print("REsponse es " + response.toString());
        },
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffa7d676))
                  )
              )),

          child: Text(
            'Registrar',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    ],
  );

  }


/*-------------------------------------*/

  _determinarNumero(String opcion, var tipos) {
    //print("Opcion es " + opcion);
    //print("Tipos es " + tipos.toString());
    return tipos.firstWhere((element) =>
    element.name == opcion, orElse: () {
      return null;
    });
  }
}