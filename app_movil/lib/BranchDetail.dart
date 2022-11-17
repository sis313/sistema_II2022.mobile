import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

import 'DTO/Branch.dart';
import 'servers/provider.dart';

class BranchDetail extends StatefulWidget {
  int idBusiness;
  BranchDetail(this.idBusiness);

  @override
  State<BranchDetail> createState() => _BranchDetailState(idBusiness);
}

class _BranchDetailState extends State<BranchDetail> {
  int idBusiness;
  _BranchDetailState(this.idBusiness);

  // Provider
  Future<List<Branch>> branches;

  // Crete Branch 1
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  String valueAtencion;
  var vectorAtencion = ['Lunes a Viernes', 'Lunes a Sabado', 'Toda la semana'];

  // Create Branch 2
  final controllerSucursal = TextEditingController();
  final ctrollerNegocioName = TextEditingController();
  final ctrollerNegocioDesc = TextEditingController();
  String zona = "";
  String municipio = "";
  String ciudad = "";

  @override
  Widget build(BuildContext context) {
    branches = Provider.of<BoActiveProvider>(context, listen: false).getBranchByBusinessId(idBusiness);

    return Scaffold(
      appBar: AppBar(
        title: Text("Branch Info"),
        backgroundColor: Color(0xffa7d676),
      ),
      body: FutureBuilder(
        future: branches,
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffa7d676),
        child: IconButton(
            onPressed: (){
              anadirSucursal_1();
            },
            icon: Icon(Icons.add),
            tooltip: "Crear nueva sucursal",
        ),
      ),
    );
  }

  Widget afterRequest(List<Branch> branch){
    return ListView.builder(
      padding: const EdgeInsets.all(17.0),
      itemCount: branch.length,
      itemBuilder: (context, index){
        return Card(
          child: branchCard(branch[index], index),
        );
      },
    );
  }

  Widget branchCard (Branch branch, int index){
    return ListTile(
      title: Text("Sucursal ${index + 1}", overflow: TextOverflow.ellipsis, maxLines: 1,),
      subtitle: Text(branch.address, overflow: TextOverflow.ellipsis, maxLines: 1,),
      trailing: popupWidget(branch),
    );
  }

  Widget popupWidget(Branch branch){
    return PopupMenuButton(
      itemBuilder: (ctx) => [
        PopupMenuItem(child: Text("Editar"), value: 0,),
        PopupMenuItem(child: Text("Eliminar"), value: 1,),
      ],
      onSelected: (value){
        setState(() {
          switch(value){
            case 0:
              editarSucursal_1(branch);
              break;
            case 1:
              eliminarSucursal();
              break;
          }
        });
      },
    );
  }

  /// ***************** Alerts para CRUD *****************
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
                                  child: Text("Cambiar"),
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
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color(0xfffbc78d)
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Color(0xfffbc78d))
                                          )
                                      )),
                                  child: Text("Cambiar"),

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
                        onPressed: () {
                          anadirSucursal_2();
                        },
                        child: Text(
                          'Continuar',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
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
                            child: Text("Buscar",
                                style: TextStyle(color: Colors.white, fontSize: 15)),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xfff9e2ae)
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Color(0xfff9e2ae))
                                    )
                                )),

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
                      child: const Text('Cancelar',style: TextStyle(color: Colors.white, fontSize: 15))
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Continuar',style: TextStyle(color: Colors.white, fontSize: 15))
                  ),
                ],
              )
            ],
          );
        }
    );
  }

  editarSucursal_1(Branch sucursal){
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
                                  child: Text("Cambiar",style: TextStyle(color: Colors.white, fontSize: 15)),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color(0xff85cbcc)
                                      ),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Color(0xff85cbcc))
                                          )
                                      )),
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
                                  child: Text("Cambiar",style: TextStyle(color: Colors.white, fontSize: 15)),style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(0xff85cbcc)
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Color(0xff85cbcc))
                                        )
                                    )),
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
                      editarSucursal_2(sucursal);
                    },
                    child: const Text('Continuar',style: TextStyle(color: Colors.white, fontSize: 15)),style: ButtonStyle(
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
  }
  editarSucursal_2(Branch sucursal){
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
  }
}
