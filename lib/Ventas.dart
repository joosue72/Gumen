import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'VentasPendientes.dart';


class Ventas extends StatefulWidget {
  @override
  _VentasState createState() => _VentasState();
}

String nombre;
double cantidad;
double costo;
String producto;

class _VentasState extends State<Ventas> {

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  

  

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
  TextFormField buildTextFormFieldProducto() {
    return TextFormField(
      decoration: InputDecoration(
        
        labelText: 'Producto',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => producto = value,
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
      onSaved: (value) => cantidad = double.tryParse(value),
    );
    
  }

  TextFormField buildTextFormFieldCosto() {
    return TextFormField(
      keyboardType: TextInputType.number,

      decoration: InputDecoration(
        
        labelText: 'Costo',
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'No deje Campos Vacios';
        }
      },
      onSaved: (value) => costo = double.tryParse(value),
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
            key: _formKey3,
            child: buildTextFormFieldProducto(),
          ),
          SizedBox(height: 8.0),
          Form(
            key: _formKey1,  
            child: buildTextFormField1(),
            
          ),
          SizedBox(height: 8.0),
          Form(
            key: _formKey2,  
            child: buildTextFormFieldCosto(),
            
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                 child: Text('Generar', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: (){

                  Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               Navigator.of(context).push(route);
                               createData();
                                                 
                }                
              ),
             
            ],
          ),
         
        ],
      ),
    );
  
  }

   void createData() async {
    if (_formKey.currentState.validate() || _formKey1.currentState.validate() || _formKey2.currentState.validate() || _formKey3.currentState.validate()) {
      _formKey.currentState.save();
      _formKey1.currentState.save();
      _formKey2.currentState.save();
      _formKey3.currentState.save();
      DocumentReference ref = await db.collection('Ventas').add({'Nombre': '$nombre', 'Cantidad': '$cantidad', 'Costo': '$costo', 'Producto': '$producto'});
      setState(() => id = ref.documentID);
      print(ref.documentID);
    }
  }

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('Ventas').document(id).get();
    print(snapshot.data['Nombre']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).updateData({'Nombre': 'Pagado'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).delete();
    setState(() => id = null);
  }

}


