
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumen/MenuProveedores.dart';

 class NombresProveedores extends StatefulWidget {
  NombresProveedores({Key key}) : super(key: key);

  @override
  _NombresProveedoresState createState() => _NombresProveedoresState();
}

final db = Firestore.instance;
String obtnombre;
String id;

class _NombresProveedoresState extends State<NombresProveedores> {


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: _getCustomAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
           StreamBuilder<QuerySnapshot>(
            stream: db.collection('NombresProveedores').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => cardbuild(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget cardbuild(DocumentSnapshot doc)
  {
    return Column(children: <Widget>[
       Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(16.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        myDetailsContainer1(doc),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                           
                          ),
                        ),

                        
                      ],)
                ),
              ),
            ),
          ),
    ],);
   
  }

  Widget myDetailsContainer1(DocumentSnapshot doc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['NombreProveedor']}",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  
               SizedBox.fromSize(
  size: Size(100, 40), // button width and height
  child: ClipRRect(
    child: Material(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
      color: Colors.redAccent, // button color
      child: InkWell(
        splashColor: Colors.green, // splash color
        onTap:  () {
          showAlertDialog(context, doc);
        }, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.delete), // icon
            Text("Borrar", style: TextStyle(color: Colors.white)), // text
          ],
        ),
      ),
    ),
  ),
),
                ],)),
        ),
        SizedBox(height: 10,),
        Container(child: Text("   Gumen \u00B7 Central Abastos   ",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
      ],
    );
  }
  _getCustomAppBar(){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFFC107),
            Color(0xFF64DD17),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MenuProveedor()),
  );

        }),
        Text('Nombres Proveedores', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.group), onPressed: (){}),
      ],),
    ),
  );
}
showAlertDialog(BuildContext context, DocumentSnapshot doc) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Borrar"),
    onPressed:  () {
      deleteData(doc);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alerta!"),
    content: Text("¿Estás seguro de que quieres eliminar este Proveedor?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
 void deleteData(DocumentSnapshot doc) async {
    await db.collection('NombresProveedores').document(doc.documentID).delete();
    setState(() => id = null);
  }
}


