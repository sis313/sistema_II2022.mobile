import 'package:app_movil/servers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'RoleMenu.dart';

class StartMenu extends StatefulWidget {
  @override
  _StartMenu createState() => _StartMenu();
}

class _StartMenu extends State<StartMenu> {
  double buttonWidth = 250;

  @override
  Widget build(BuildContext context) {
    final elevButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.black,
      padding: EdgeInsets.all(10),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(text: "Bienvenido a ", style: TextStyle(fontSize: 30)),
                TextSpan(
                  children: <TextSpan> [
                    TextSpan(text: "Bienvenido a ", style: TextStyle(fontSize: 30)),
                    TextSpan(text: "BoaActive", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xffa7d676))),
                    TextSpan(text: "!", style: TextStyle(fontSize: 30)),
                  ]
                )
              ]),
            )
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage('assets/Logo_BOActive.png'),
                )
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Inicia sesión',
                style: TextStyle(color: Color(0xffffffff), fontSize: 15),
              ),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xffa7d676)
    ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color(0xffa7d676))
            )
        )),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 250,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RoleMenu()));
                },
                child: Text(
                  'Regístrate',
                  style: TextStyle(color: Color(0xffffffff), fontSize: 15),

                ),

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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // City
          /*
          Provider.of<BoActiveProvider>(context, listen: false).getCity();

          // Municipio
          Provider.of<BoActiveProvider>(context, listen: false).getMunicipio();
          Provider.of<BoActiveProvider>(context, listen: false).getByIDMunicipio(2);

          // Comment
          Provider.of<BoActiveProvider>(context, listen: false).getComent();
          Provider.of<BoActiveProvider>(context, listen: false).createComment("test message 2", 1, 1);
          Provider.of<BoActiveProvider>(context, listen: false).updateComment(7, "test message edited", 1, 1);
          //Provider.of<BoActiveProvider>(context, listen: false).deleteComment(6);

          */
          // Rating
          Provider.of<BoActiveProvider>(context, listen: false).getRanting();
          Provider.of<BoActiveProvider>(context, listen: false).createRanking(3, 1, 1);
          Provider.of<BoActiveProvider>(context, listen: false).updateRating(11, 5, true, 1, 1);

          /*
          // Business
          Provider.of<BoActiveProvider>(context, listen: false).getBusiness();
          Provider.of<BoActiveProvider>(context, listen: false).getBusinessById(2);
          Provider.of<BoActiveProvider>(context, listen: false).getBusinessByUserId(1);
          Provider.of<BoActiveProvider>(context, listen: false).createBusiness("my last test business", "my last test business", 1, 1, "2022-10-24", "2022-10-24");
          Provider.of<BoActiveProvider>(context, listen: false).updateBusiness(8, "my last test business edit", "i dont wanna edit this :(", 1, 1, "2022-10-24", "2022-10-24");
          Provider.of<BoActiveProvider>(context, listen: false).deleteBusinessById(8);

          // Type Business
          Provider.of<BoActiveProvider>(context, listen: false).getTypeBusiness();
          Provider.of<BoActiveProvider>(context, listen: false).getTypeBusinessById(1);
          Provider.of<BoActiveProvider>(context, listen: false).createTypeBusiness("bar");
          Provider.of<BoActiveProvider>(context, listen: false).updateTypeBusiness(5, "bar edited");
          Provider.of<BoActiveProvider>(context, listen: false).deleteTypeBusinessById(5);

          // Location
          Provider.of<BoActiveProvider>(context, listen: false).getLocation();
          Provider.of<BoActiveProvider>(context, listen: false).getLocationById(1);
          Provider.of<BoActiveProvider>(context, listen: false).createLocation(12.576, 12.654);
          Provider.of<BoActiveProvider>(context, listen: false).updateLocation(12, 12.576, 12.576);
          Provider.of<BoActiveProvider>(context, listen: false).deleteBranch(10);

          // Branch
          Provider.of<BoActiveProvider>(context, listen: false).getBranch();
          Provider.of<BoActiveProvider>(context, listen: false).getBranchById(1);
          Provider.of<BoActiveProvider>(context, listen: false).getBranchByBusinessId(1);
          */
         // Provider.of<BoActiveProvider>(context, listen: false).createBranch('Av. Pando','08:00:00','18:00:00','Lunes','https://sistemasii2022.s3.amazonaws.com/49d1f1744ec444e88b917c0e596c3556',1,2,1,'2022-01-01','2022-01-01');
          /*
          Provider.of<BoActiveProvider>(context, listen: false).updateBranch(3,"Av. Potosi","08:00:00","18:00:00","Lunes","https://sistemasii2022.s3.amazonaws.com/49d1f1744ec444e88b917c0e596c3556",3,3,1,"2022-01-01","2022-01-01");
          Provider.of<BoActiveProvider>(context, listen: false).deleteBranch(4);
          */
        },
        child: Icon(Icons.account_tree_sharp),
      ),
    );
  }
}
