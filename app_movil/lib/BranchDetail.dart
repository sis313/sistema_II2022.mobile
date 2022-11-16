import 'package:flutter/material.dart';
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

  Future<List<Branch>> branches;

  @override
  Widget build(BuildContext context) {
    branches = Provider.of<BoActiveProvider>(context, listen: false).getBranchByBusinessId(idBusiness);

    return Scaffold(
      appBar: AppBar(
        title: Text("Branch Info"),
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
      )
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
      trailing: popupWidget(branch.idBranch),
    );
  }

  Widget popupWidget(int idSucursal){
    return PopupMenuButton(
      itemBuilder: (ctx) => [
        PopupMenuItem(child: Text("Editar"), value: 0,),
        PopupMenuItem(child: Text("Eliminar"), value: 1,),
      ],
      onSelected: (value){
        setState(() {
          switch(value){
            case 0:
              print("Editar sucursal...");
              break;
            case 1:
              print("Eliminar sucursal...");
              break;
          }
        });
      },
    );
  }
}
