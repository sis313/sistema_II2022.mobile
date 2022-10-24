import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoder/geocoder.dart';

import 'DTO/Negocio.dart';
import 'DTO/Sucursal.dart';

class OwnerMenu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _OwnerMenuState();
}

class _OwnerMenuState extends State<OwnerMenu> {

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
  var vectorCategorias  = ['Categoria 1', 'Categoria 2', 'Categoria 3'];
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

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Mis Negocios'),
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
          body: ListView.builder(
            itemCount: negocios.length,
            itemBuilder: (context, index){
              return Card(
                child: negocio(negocios[index]),
              );
            },
          )
      ),
    );
  }

  //Lista de widgets a partir de lista con datos
  List<Widget> listarNegocios(List<Negocio> negocios){

    List<Widget> widgets = [];

    for(int i = 0; i < negocios.length; i++){
      widgets.add(negocio(negocios[i]));
    }

    return widgets;
  }
/*-------------------------------------*/
/*WIDGETS PARA EL LISTADO*/
  Widget negocio(Negocio negocio){

    String nombre = negocio.name.toString();
    int sucursales = negocio.sucursales.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Icon(
              Icons.house,
              size: 50,
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Text(
                  'Numero de sucursales ($sucursales)',
                  style: TextStyle(
                      fontSize: 18
                  ),
                )
              ],
            ),
            SizedBox(width: 50),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  setState(() {
                    if(negocio.wState == true)
                      negocio.wState = false;
                    else
                      negocio.wState = true;
                    print(negocio.wState);
                  });
                },
                icon: (negocio.wState ?
                Icon(Icons.indeterminate_check_box_outlined, size: 50) :
                Icon(Icons.add_box_outlined, size: 50))
            )
          ],
        ),
        (negocio.wState ?
        ListView.builder(
            shrinkWrap: true,
            itemCount: sucursales,
            itemBuilder: (_, index){
              return sucursal(negocio.sucursales[index]);
            })
            : SizedBox(height: 0)
        ),
        (negocio.wState ?
        TextButton(
          child: Text("Añadir Sucursal"),
          onPressed: (){
            setState(() {
              print("Añadir sucursal");
              anadirSucursal_1();
            });
          },
        ) : SizedBox(height: 0)),
      ],
    );
  }

  Widget sucursal (Sucursal sucursal){

    String nombre = sucursal.name.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
          width: 20,
        ),
        Text(
          nombre,
          style: TextStyle(
              fontSize: 15
          ),
        ),
        SizedBox(
          height: 25,
          width: 190,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  setState(() {
                    editarSucursal_1(negocios[0].sucursales[0]);
                  });
                },
                icon: Icon(Icons.edit)
            ),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  setState(() {
                    eliminarSucursal();
                  });
                },
                icon: Icon(Icons.delete_outline)
            )
          ],
        )
      ],
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
    GlobalKey<FormState> formkeyName = GlobalKey<FormState>();
    GlobalKey<FormState> formkeyDesc = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Nuevo Negocio'),
      content: Form(
          child: Column(
            children: [
              TextFormField(
                controller: ctrollerNegocioName,
                autovalidateMode: AutovalidateMode.always,
                key: formkeyName,
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "Campo Requerido"
                  ),
                ]),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nombre de Negocio *',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ctrollerNegocioDesc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descripcion',
                ),
              ),
              DropdownButtonFormField<String>(
                  key: formkeyDesc,
                  validator: (value) => value == null?
                  'Campo requerido' : null,
                  value: valueCategorias,
                  items: vectorCategorias.map(
                          (String e) =>
                          DropdownMenuItem<String>(
                              value: e,
                              child: Text(e)
                          )
                  ).toList(),
                  onChanged: (String value) {
                      if(formkeyDesc.currentState.validate())
                        setState(() {
                          this.valueCategorias = value;
                        });
                  }
              )
            ],
          ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar')
        ),
        TextButton(
            onPressed: () {
              print(ctrollerNegocioName.text);
              print(ctrollerNegocioDesc.text);
              print(valueCategorias);
            },
            child: const Text('Registrar')
        ),
      ],
    );
  }

  anadirSucursal_1(){
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: const Text('Nueva Sucursal'),
                content: StatefulBuilder(
                  builder: (BuildContext c, StateSetter setState){
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Abre a las : ${openTime.hour}:${openTime.minute}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay newTime = openTime;
                                      newTime = await showTimePicker(
                                          context: context,
                                          initialTime: openTime
                                      );

                                      if(newTime == null) return;

                                      setState(() {
                                        openTime = newTime;

                                        if(openTime.hour >= closeTime.hour)
                                          closeTime = openTime;
                                      });
                                    },
                                    child: Text("Cambiar")
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Cierra a las : ${closeTime.hour}:${closeTime.minute}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay newTime = closeTime;
                                      newTime = await showTimePicker(
                                          context: context,
                                          initialTime: closeTime
                                      );
                                      setState(() {
                                        if(newTime == null ||
                                            (openTime.hour == newTime.hour &&
                                                openTime.minute > newTime.minute) ||
                                            openTime.hour > newTime.hour)
                                          closeTime = openTime;
                                        else
                                          closeTime = newTime;
                                      });
                                    },
                                    child: Text("Cambiar")
                                ),
                              ],
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                            value: valueAtencion,
                            items: vectorAtencion.map(
                                    (String e) =>
                                    DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e)
                                    )
                            ).toList(),
                            onChanged: (String value) {
                              setState(() {
                                this.valueAtencion = value;
                              });
                            }
                        )
                      ],
                    );
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar')
                  ),
                  TextButton(
                      onPressed: () {
                        anadirSucursal_2();
                      },
                      child: const Text('Continuar')
                  ),
                ],
              )
            ],
          );
        }
    );
  }

  anadirSucursal_2(){
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: const Text('Nueva Sucursal'),
                content: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formkey,
                  child: StatefulBuilder(
                    builder: (BuildContext c, StateSetter setState){
                      return Column(
                        children: [
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Campo Requerido"
                              ),
                            ]),
                            controller: controllerSucursal,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Direccion',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            child: Text("Buscar"),
                            onPressed: () async {
                              var addresses = await Geocoder.local.findAddressesFromQuery(controllerSucursal.text);

                              var first = addresses.first;
                              setState(() {
                                zona = first.subLocality;
                                municipio = first.adminArea;
                                ciudad = first.locality;

                                print("Direccion: ${first.addressLine}");
                                print("AdminArea: ${first.adminArea}");//Municipio
                                print("CountryName: ${first.countryName}");
                                print("FeatureName: ${first.featureName}");
                                print("Localidad: ${first.locality}"); //Ciudad
                                print("SubAdminArea: ${first.subAdminArea}");//Provincia
                                print("SubLocality: ${first.subLocality}"); //Zona
                                print("SubThoroughfare: ${first.subThoroughfare}");
                                print("Thoroughfare: ${first.thoroughfare}");
                              });
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Zona: ${zona}"),
                              Text("Munic.: ${municipio}"),
                              Text("Ciudad: ${ciudad}"),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        },
                      child: const Text('Cancelar')
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Continuar')
                  ),
                ],
              )
            ],
          );
        }
    );
  }

  editarSucursal_1(Sucursal sucursal){
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: const Text('Editar Sucursal'),
                content: StatefulBuilder(
                  builder: (BuildContext c, StateSetter setState){
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Abre a las : ${openTime.hour}:${openTime.minute}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay newTime = openTime;
                                      newTime = await showTimePicker(
                                          context: context,
                                          initialTime: openTime
                                      );

                                      if(newTime == null) return;

                                      setState(() {
                                        openTime = newTime;

                                        if(openTime.hour >= closeTime.hour)
                                          closeTime = openTime;
                                      });
                                    },
                                    child: Text("Cambiar")
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Cierra a las : ${closeTime.hour}:${closeTime.minute}",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay newTime = closeTime;
                                      newTime = await showTimePicker(
                                          context: context,
                                          initialTime: closeTime
                                      );
                                      setState(() {
                                        if(newTime == null ||
                                            (openTime.hour == newTime.hour &&
                                                openTime.minute > newTime.minute) ||
                                            openTime.hour > newTime.hour)
                                          closeTime = openTime;
                                        else
                                          closeTime = newTime;
                                      });
                                    },
                                    child: Text("Cambiar")
                                ),
                              ],
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                            value: valueAtencion,
                            items: vectorAtencion.map(
                                    (String e) =>
                                    DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e)
                                    )
                            ).toList(),
                            onChanged: (String value) {
                              setState(() {
                                this.valueAtencion = value;
                              });
                            }
                        )
                      ],
                    );
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar')
                  ),
                  TextButton(
                      onPressed: () {
                        editarSucursal_2(sucursal);
                      },
                      child: const Text('Continuar')
                  ),
                ],
              )
            ],
          );
        }
    );
  }

  editarSucursal_2(Sucursal sucursal){

    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: const Text('Nueva Sucursal'),
                content: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formkey,
                  child: StatefulBuilder(
                    builder: (BuildContext c, StateSetter setState){
                      return Column(
                        children: [
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Campo Requerido"
                              ),
                            ]),
                            controller: controllerSucursal,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Direccion',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            child: Text("Buscar"),
                            onPressed: () async {
                              var addresses = await Geocoder.local.findAddressesFromQuery(controllerSucursal.text);

                              var first = addresses.first;
                              setState(() {
                                zona = first.subLocality;
                                municipio = first.adminArea;
                                ciudad = first.locality;

                                print("Direccion: ${first.addressLine}");
                                print("AdminArea: ${first.adminArea}");//Municipio
                                print("CountryName: ${first.countryName}");
                                print("FeatureName: ${first.featureName}");
                                print("Localidad: ${first.locality}"); //Ciudad
                                print("SubAdminArea: ${first.subAdminArea}");//Provincia
                                print("SubLocality: ${first.subLocality}"); //Zona
                                print("SubThoroughfare: ${first.subThoroughfare}");
                                print("Thoroughfare: ${first.thoroughfare}");
                              });
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Zona: ${zona}"),
                              Text("Munic.: ${municipio}"),
                              Text("Ciudad: ${ciudad}"),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar')
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Continuar')
                  ),
                ],
              )
            ],
          );
        }
    );
  }

  eliminarSucursal(){
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
                      child: const Text('Cancelar')
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Eliminar')
                  ),
                ],
              )
            ],
          );
        }
    );
  }
}
