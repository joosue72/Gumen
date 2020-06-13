import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Ventas extends StatefulWidget {
  @override
  _VentasState createState() => _VentasState();
}

String nombre;
String cantidad;


class _VentasState extends State<Ventas> {

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  

  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nombre: ${doc.data['Nombre']}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Cantidad: ${doc.data['Cantidad']}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateData(doc),
                  child: Text('Pagar', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => deleteData(doc),
                  child: Text('Borrar', style: TextStyle(color: Colors.white),),
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        
        labelText: 'Nombre',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => nombre = value,
    );
    
  }
  TextFormField buildTextFormField1() {
    return TextFormField(
      keyboardType: TextInputType.number,
      
      decoration: InputDecoration(

         labelText: 'Cantidad',
         fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      }, 
      onSaved: (value) => cantidad = value,
    );
    
  }
  


  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: buildTextFormField(),
          ),
          SizedBox(height: 8.0),
          Form(
            key: _formKey1,  
            child: buildTextFormField1(),
            
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: createData,             
                child: Text('Generar', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                
                
              ),
             
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('Ventas').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  
  }

   void createData() async {
    if (_formKey.currentState.validate() || _formKey1.currentState.validate()) {
      _formKey.currentState.save();
      _formKey1.currentState.save();
      DocumentReference ref = await db.collection('Ventas').add({'Nombre': '$nombre', 'Cantidad': '$cantidad'});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('Ventas').document(id).get();
    print(snapshot.data['Nombre']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).updateData({'Nombre': 'Juan'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).delete();
    setState(() => id = null);
  }

}
