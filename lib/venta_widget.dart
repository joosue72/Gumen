import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Grafica_Pie.dart';
import 'graph_widget.dart';

enum GraphType {
  LINES, PIE,
}




class VentaWidget extends StatefulWidget {

 final List<DocumentSnapshot> documents;
 final double total;
 final List<double> perDay;
 final Map<String,double>categories;
 final GraphType graphType;

   VentaWidget({Key key, this.graphType,this.documents}) : 
    total = documents.map((doc) => doc['Costo'])
            .fold(0.0, (a, b) => a + b),
     
     
     perDay = List.generate(30, (int index){
       return documents.where((doc) => doc['Dia'] ==(index + 1))
        .map((doc) => doc['Costo'])
            .fold(0.0, (a, b) => a + b);
     }),       

      categories = documents.fold({}, (Map<String, double> map,document){

        if(!map.containsKey(document['Producto'])){
          map[document['Producto']] = 0.0;
        }

        map[document['Producto']] += document['Costo'];
        return map;

      }),

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
    if (widget.graphType == GraphType.LINES) {
      return Container(
        height: 250.0,
        child: GraphWidget(
          data: widget.perDay,
        ),
      );
    } 
    
      if (widget.graphType == GraphType.PIE) {
      var perCategory = widget.categories.keys.map((name) => widget.categories[name] / widget.total).toList();
      return Container(
        height: 250.0,
        child: PieGraphWidget(
          data: perCategory,
        ),
      );
    }
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
            itemCount: widget.categories.keys.length,
            itemBuilder: (BuildContext context, int index) { 
              var key = widget.categories.keys.elementAt(index);
              var data = widget.categories[key];
              
              return _item(FontAwesomeIcons.shoppingCart,key, 100*data ~/ widget.total,data);
              }, 
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


