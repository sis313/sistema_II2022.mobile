import 'dart:async';
import 'dart:core';
import 'package:app_movil/DTO/Branch.dart';
import 'package:app_movil/DTO/BranchInfo.dart';
import 'package:app_movil/DTO/Location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:app_movil/servers/provider.dart';
import 'package:provider/provider.dart';

import 'DTO/Business.dart';

class MapSample extends StatefulWidget {
  final List<Business> ListBusiness;
  MapSample(this.ListBusiness);

  //const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  List<Branch> branches = [];
  List<BranchInfo> sucursales = [];

  var user_position ;
  bool showUser = false;
  bool loading = true;
  double lminLat, lmaxLat, lminLon, lmaxLon, radio = 1.0;
  List FilterBranch = [];
  List<Marker> listMarks = [];


  @override
  void initState() {
    super.initState();
    loading = true;
    setBranches(widget.ListBusiness);
  }




  void getCurrentLocation() async {

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("user = $position.latitude, $position.longitude ");

    setState(() {
      user_position  = position;
      showUser = true;
    });

    var m = Marker(
        //for emulator
        point: LatLng(-16.493730639624058, -68.13252864400924),
      //for apk
        //point: LatLng(user_position.latitude, user_position.longitude),
        builder: (context) => Icon(
          Icons.person_pin,
          color: Colors.red,
          size: 50,
        )
    );
    listMarks.add(m);
    // for emulator
    CalulateLimits(-16.493730639624058, -68.13252864400924);
    // for apk
    //CalulateLimits(position.latitude, position.longitude);
    BranchOfficeFilter();
    SetMarkers(FilterBranch);

  }


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
    for(var branch in sucursales) {
      double lat = branch.latitude;
      double lon = branch.longitude;
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
    for(BranchInfo b in branches) {
      //print(b.elementAt(2));
      //String suc = b.elementAt(1);
      Marker m = Marker(
          point: LatLng(b.latitude, b.longitude),
          builder: (context) => GestureDetector(
              child: Icon(Icons.pin_drop, size: 40),
              onTap: (){
                showModalBottomSheet (
                    context: context,
                    builder: (builder)=> info(b));

              },

          ),
      );
      listMarks.add(m);
    }
    print(listMarks.length);
    setState((){
      loading = false;
    });

  }

  void setBranches(List<Business> listBusiness) async {
    //print('length business ${listBusiness.length}');
    for (Business b in listBusiness) {
      print(b.idBusiness);
      branches = await Provider.of<BoActiveProvider>(context, listen: false).getBranchByBusinessId(b.idBusiness);
      print(branches);
      print('------------------');
      if(branches.length > 0){
        for (Branch br in branches) {
          Location location = await Provider.of<BoActiveProvider>(context, listen: false).getLocationById(br.idLocation);
          print("dirrecion> $location");
          BranchInfo bi = BranchInfo();
          bi.name = b.name;
          bi.address = br.address;
          bi.openHour = br.openHour;
          bi.closeHour = br.closeHour;
          bi.attentionDays = br.attentionDays;
          bi.latitude = location.latitude;
          bi.longitude = location.longitude;
          sucursales.add(bi);
        }
      }
    }
    print('length sucursales ${sucursales.length}');
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
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
                  options: MapOptions(
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
                  ],


                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    loading ? LoadingWidget():MarkerLayer(
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


  info (BranchInfo b) {
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
                    b.name,
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
                "Dirección: ${b.address}",
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
                "Horario de atención: \n${b.openHour} - ${b.closeHour}",
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
                "Atención los días: \n${b.attentionDays}",
                style: TextStyle(
                    fontSize: 24
                ),

              ),

            ),
          ],
        )
      ],
    );
  }

  Widget LoadingWidget () {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }


}
