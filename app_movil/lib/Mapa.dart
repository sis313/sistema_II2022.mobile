import 'dart:async';
import 'dart:core';
import 'package:app_movil/DTO/Branch.dart';
import 'package:app_movil/DTO/BranchInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:provider/provider.dart';

import 'DTO/Business.dart';
import 'DTO/Negocio.dart';
import 'DTO/Sucursal.dart';

class MapSample extends StatefulWidget {
  final List<Business> ListBusiness;
  MapSample(this.ListBusiness);

  //const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  Future<List<Branch>> branches;
  List<BranchInfo> sucursales;

  var user_position ;
  bool showUser = false;
  double lminLat, lmaxLat, lminLon, lmaxLon, radio = 5.0;
  List FilterBranch = [];
  List<Marker> listMarks = [];


  @override
  void initState() {
    super.initState();
  }




  void getCurrentLocation() async {

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("user = $position.latitude, $position.longitude ");

    setState(() {
      user_position  = position;
      showUser = true;

    });

    var m = Marker(
        point: LatLng(-16.493730639624058, -68.13252864400924),
        //point: LatLng(user_position.latitude, user_position.longitude),
        builder: (context) => Icon(
          Icons.person_pin,
          color: Colors.red,
          size: 50,
        )
    );
    listMarks.add(m);
    CalulateLimits(-16.493730639624058, -68.13252864400924);
    //CalulateLimits(position.latitude, position.longitude);
    BranchOfficeFilter();
    SetMarkers(FilterBranch);

  }

  /*//Datos de prueba para listado
  var negocios = [
    Negocio(1, 'Nombre Negocio 1', [Sucursal(1, 'Sucursal 1', ''), Sucursal(2, 'Sucursal 2', '')]),
    Negocio(2, 'Nombre Negocio 2', [Sucursal(3, 'Sucursal 1', '')]),
    Negocio(3, 'Nombre Negocio 3', [Sucursal(4, 'Sucursal 1', '')]),
    Negocio(4, 'Nombre Negocio 4', [Sucursal(5, 'Sucursal 1', '')]),
    Negocio(5, 'Nombre Negocio 5', [Sucursal(6, 'Sucursal 1', '')]),
    Negocio(6, 'Nombre Negocio 6', [Sucursal(7, 'Sucursal 1', '')]),
  ];
*/
  var Sucursales = [
    {1, 'sucursal 1', -16.509119931820113, -68.12710156327141},
    {2, 'sucursal 2', -36.493730639624058,-14.493730639624058},
    {3, 'sucursal 3', -22.493730639624058,-60.493730639624058},
    {4, 'sucursal 4', -46.493730639624058,-23.493730639624058},
    {5, 'sucursal 5', -50.493730639624058,-3.493730639624058},
  ];


  void CalulateLimits( userLat, userLon )  {
    print("calculate");
    setState(() {
      lminLat = userLat - radio;
      lmaxLat = userLat + radio;
      lminLon = userLon - radio;
      lmaxLon = userLon + radio;
    });

  }

  void BranchOfficeFilter(){

    print("filter");
    print('$lminLat');
    print('$lmaxLat');
    for(var branch in Sucursales) {
      double lat = branch.elementAt(2);
      double lon = branch.elementAt(3);
      print('$lat, $lon');
      if ((lat > lminLat && lat < lmaxLat) && (lon > lminLon && lon < lmaxLon)){

        //print('$lat, $lon');
        FilterBranch.add(branch);
      }

    }
    print("filter branch = ${FilterBranch.length}");
  }

  void SetMarkers(branches){
    print("set marker");
    print("lista suc = ${branches.length}");
    for(var b in branches) {
      print(b.elementAt(2));
      String suc = b.elementAt(1);
      Marker m = Marker(
          point: LatLng(b.elementAt(2), b.elementAt(3)),
          builder: (context) => GestureDetector(
              child: Icon(Icons.pin_drop, size: 40),
              onTap: (){
                showModalBottomSheet (
                    context: context,
                    builder: (builder){
                      return Column(
                        children: <Widget>[
                            Container(
                              color: Color(0xffa7d676),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                          "Nombre del negocio",
                                        style: TextStyle(
                                          fontSize: 24
                                        ),

                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                    Icons.pin_drop_outlined,
                                    size: 40,
                                    color: Color(0xff85cbcc),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: Text(
                                      "Direccion",
                                      style: TextStyle(
                                          fontSize: 24
                                      ),

                                    ),

                                ),
                              ],
                            ),

                            Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.watch_later_outlined,
                                size: 40,
                                color: Color(0xff85cbcc),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Horario",
                                  style: TextStyle(
                                      fontSize: 24
                                  ),

                                ),

                              ),
                            ],
                          ),

                            Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 40,
                                color: Color(0xff85cbcc),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Atencion",
                                  style: TextStyle(
                                      fontSize: 24
                                  ),

                                ),

                              ),
                            ],
                          )
                        ],
                      );
                    });

              },

          ),
      );
      listMarks.add(m);
    }
    print(listMarks.length);
  }



  @override
  Widget build(BuildContext context) {

    void setBranches(List<Business> listBusiness){
      for (Business b in listBusiness) {
        Branch branch = Provider.of<BoActiveProvider>(context, listen: false).getBranchByBusinessId(b.idBusiness);
        if(branch != null){
          BranchInfo bi = new BranchInfo(b.name, branch.address, branch.openHour, branch.closeHour, branch.attentionDays);
          sucursales.add(bi);
        }
      }
    }


    final elevButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 10,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
                child: FlutterMap(
                  options: MapOptions(// Coordenadas Plaza Murillo -16.493730639624058, -68.13252864400924
                    center: LatLng(-16.493730639624058, -68.13252864400924),
                      zoom: 12,
                      maxZoom: 18,
                      minZoom: 12
                  ),
                  nonRotatedChildren: [
                    AttributionWidget.defaultWidget(
                      source: 'OpenStreetMap contributors',
                      onSourceTapped: null,
                    ),
                    Align(
                    alignment: Alignment(0.9, 0.9),
                    child:
                    ElevatedButton(
                      child: const Icon(
                        Icons.adjust_sharp,
                        color: Colors.white,
                        size: 40,
                      ),
                      style: elevButtonStyle,
                      onPressed: () {
                        //getCurrentLocation();
                        setBranches(widget.ListBusiness);
                      },),
                  )],

                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: listMarks
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );

  }

  info (Sucursal sucursal) {
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlertDialog(
                title: Text(sucursal.name),
                content: Column(
                  children: [
                    Text(sucursal.address),
                    Text("Info 2"),
                    Text("Info 3"),
                  ],
                )
              )
            ],
          );
        }
    );
  }


}
