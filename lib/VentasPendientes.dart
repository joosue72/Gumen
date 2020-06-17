import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

  String id;
  final db = Firestore.instance;

class VentasPendientes extends StatefulWidget {
 @override
  _VentasPendientesState createState() => _VentasPendientesState();
    
}

class _VentasPendientesState extends State<VentasPendientes> {

  
  Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nombre: ${doc.data['Nombre']}            ${doc.data['Producto']} ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Cantidad: ${doc.data['Cantidad']} Kg',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Total: ${doc.data['Costo']} ',
              style: TextStyle(fontSize: 16),
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



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Ventas Pendientes'),
      ),
        body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          
             StreamBuilder<QuerySnapshot>(
            stream: db.collection('Ventas').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          ),
            ],
          ),
         


     );
  }
  
  void updateData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).updateData({'Nombre': 'Pagado'});
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Ventas').document(doc.documentID).delete();
    setState(() => id = null);
  }
}