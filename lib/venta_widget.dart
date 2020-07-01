import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'graph_widget.dart';

class VentaWidget extends StatefulWidget {

 final List<DocumentSnapshot> documents;
 final double total;

   VentaWidget({Key key, this.documents}) : 
    total = documents.map((doc) => doc['Costo'])
            .fold(0.0, (a, b) => a + b),
    super(key: key);

  @override
  _VentaWidgetState createState() => _VentaWidgetState();
}

class _VentaWidgetState extends State<VentaWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
      children: <Widget>[
       _expenses(),
          _graph(),
          Container(
                color: Colors.blueAccent.withOpacity(0.1),
                height: 24.0,
              ),
          _list(),
      ],
    ),
    );
  }


    Widget _expenses() {
    return Column(
      children: <Widget>[
        Text("\$${widget.total.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Total de Ventas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
  
  
  Widget _graph() {
    return Container(
      height: 250.0,
      child: GraphWidget(),
    );
  }
  
  Widget _item(IconData icon, String nombre, int percent,double value){
    return ListTile(
      leading: Icon(icon, size: 32.0,),
      title: Text(nombre,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0 
        ),
      ),
      subtitle: Text("$percent% de Ventas",
        style: TextStyle(
          fontSize: 16.0,
          color:Colors.blueGrey
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("\$$value",
            style: TextStyle(
              color:Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        )
        
        ),
      
      
      );
  }
  Widget _list() {
    return Expanded(
          child: ListView.separated(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) => _item(FontAwesomeIcons.shoppingCart, "Shopping",14, 145.12), 
            separatorBuilder: (BuildContext context, int index){
              return Container(
                color: Colors.blueAccent.withOpacity(0.15),
                height: 8.0,
              );
            },
        ),
    );
  }
  
}


