import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gumen/MenuProveedores.dart';




 class DetallesProveedores extends StatefulWidget {
  DetallesProveedores({Key key}) : super(key: key);

  @override
  _DetallesProveedoresState createState() => _DetallesProveedoresState();
}

final db = Firestore.instance;
String obtnombre;
String id;
dynamic pago, abono=0, total=0;
var selectedCurrency1, selectedType1;

class _DetallesProveedoresState extends State<DetallesProveedores> {
  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _getCustomAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 50.0),
          Form(
            //Nombre
            child:  ListView(
              scrollDirection: Axis.vertical,
    shrinkWrap: true,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 55.0,),
                     StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('NombresProveedores').snapshots(),
                  
                  builder: (context, snapshot) {
                    
                    if (!snapshot.hasData)

                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              
                              snap.reference.documentID,
                              style: TextStyle(color: Color.fromARGB(255,98,97,97)),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          
                          DropdownButton(
                            
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Proveedor: $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency1 = currencyValue;
                              });
                            },
                            value: selectedCurrency1,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Proveedor",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                 
                  ],
                  
                ),
                
              ],
            ),
          ),
           StreamBuilder<QuerySnapshot>(
            stream: db.collection('Proveedores').where("NombreProveedor", isEqualTo: selectedCurrency1).snapshots(),
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
    pago = doc.data['Pago'];
    abono = doc.data['Abono'];
    total = pago - abono;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['NombreProveedor']}",
            style: TextStyle(color: Color(0xFFFFC107), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Container(child: Text(" ${doc.data['Fecha']}",
                    style: TextStyle(color: Colors.black54, fontSize: 12.0, ),)),
                    SizedBox(height: 10,),
                    Container(child: Text(" (${doc.data['Cantidad']}) \u00B7 Kg",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                    SizedBox(height: 10,),
                    Container(child: Text("Total ${doc.data['Pago']}\$ \u00B7  Abono ${doc.data['Abono']}\$" ,
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,), )
                    
                    ),
                    SizedBox(height: 10,),
                    
                    
                     Container(child: Text(" Adeudo = "+total.toString()+"\$",
                    style: TextStyle(color: Colors.black, fontSize: 18.0,),)),
                    
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
      color: Color(0xFF64DD17), // button color
      child: InkWell(
        splashColor: Colors.green, // splash color
        onTap:  () {
         _displayDialog(context, doc);
        }, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.edit), // icon
            Text("Editar", style: TextStyle(color: Colors.white)), // text
          ],
        ),
      ),
    ),
  ),
),
                ],)),
        ),
        
        SizedBox(height: 10),
        Container(child: Text("   Gumen   " ,
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
        Text('Detalles Proveedores', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.group), onPressed: (){}),
      ],),
    ),
  );
}
TextEditingController _textFieldController = TextEditingController();
_displayDialog(BuildContext context, DocumentSnapshot doc) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar Abono'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(suffixText:'${doc.data['Abono']}'), 
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Guardar'),
                onPressed: () {
                  abono = double.parse(_textFieldController.text);
                  print(abono);
                  Navigator.of(context).pop();
                  
                  updateCantidad(doc);
                },
              
              )
            ],
          );
        });
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
  void updateCantidad(DocumentSnapshot doc) async {
    abono = double.parse(_textFieldController.text);

    await db.collection('Proveedores').document(doc.documentID).updateData({'Abono': abono});
  
    
  }

  
}