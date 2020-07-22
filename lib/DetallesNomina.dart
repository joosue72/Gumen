import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MenuNominas.dart';


 class DetallesNomina extends StatefulWidget {
  DetallesNomina({Key key}) : super(key: key);

  @override
  _DetallesNominaState createState() => _DetallesNominaState();
}

final db = Firestore.instance;
String obtnombre;
String id;
double pago;
var selectedCurrency1, selectedType1;

class _DetallesNominaState extends State<DetallesNomina> {
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
                       
                  stream: db.collection('NombresNomina').snapshots(),
                  
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
                                  'Empleado: $currencyValue',
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
                              "Seleccione Empleado",
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
            stream: db.collection('Nomina').where("Empleado", isEqualTo: selectedCurrency1).snapshots(),
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
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['Empleado']}",
            style: TextStyle(color: Color(0xFFF4511E), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Container(child: Text(" ${doc.data['Fecha']}",
                    style: TextStyle(color: Colors.black54, fontSize: 12.0, ),)),
                    
                    SizedBox(height: 10,),
                    Container(child: Text("Pago ${doc.data['Pago']}\$ " ,
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,), )
                    
                    ),
                    SizedBox(height: 10,),
                    
                    
                    
                    
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
      color: Color(0xFFF4511E), // button color
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
            Color(0xFFF4511E),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MenuNominas()),
  );

        }),
        Text('Detalles Nominas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.payment), onPressed: (){}),
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
            title: Text('Editar Pago'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(suffixText:'${doc.data['Pago']}'), 
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Guardar'),
                onPressed: () {
                  pago = double.parse(_textFieldController.text);
                  print(pago);
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
    content: Text("¿Estás seguro de que quieres eliminar este Registro?"),
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
    await db.collection('Nomina').document(doc.documentID).delete();
    setState(() => id = null);
  }
  void updateCantidad(DocumentSnapshot doc) async {
    pago = double.parse(_textFieldController.text);

    await db.collection('Nomina').document(doc.documentID).updateData({'Pago': pago});
  
    
  }
}