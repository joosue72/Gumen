import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'details_page_gastos.dart';

import 'Grafica_Pie_gastos.dart';
import 'graph_widget_gastos.dart';

enum GraphType {
  LINES, PIE,
}




class VentaWidget extends StatefulWidget {

 final List<DocumentSnapshot> documents;
 final double total;
  
 final List<double> perDay;
  final double perDay2;
  
 final Map<String,double>categories;
 final GraphType graphType;
 final int month;
 final  int currentPage = DateTime.now().year ;
 

   VentaWidget({Key key,@required this.month, this.graphType,this.documents}) : 
    total = documents.map((doc) => doc['Pago'])
            .fold(0.0, (a, b) => a + b),
     
     
     perDay = List.generate(30, (int index){
       return documents.where((doc) => doc['Dia'] ==(index + 1))
        .map((doc) => doc['Pago'])
            .fold(0.0, (a, b) => a + b);
          
     }),    

     perDay2 = documents.where((doc) => doc['Dia'] ==(DateTime.now().day- 1))
        .map((doc) => doc['Pago'])
            .fold(0.0, (a, b) => a + b),
   
          
       
      categories = documents.fold({}, (Map<String, double> map,document){

        if(!map.containsKey(document['Empleado'])){
          map[document['Empleado']] = 0.0;
        }

        map[document['Empleado']] += document['Pago'];
        return map;

      }),

    super(key: key);

    

  @override
  _VentaWidgetState createState() => _VentaWidgetState();
}

class _VentaWidgetState extends State<VentaWidget> {
 double year= 0;
 int currentPage = DateTime.now().year;
 String t ; double total;  double resultado;
final db = Firestore.instance;
   @override
  void initState() {
    super.initState();
    

    db
                .collection('Nomina')
                .where("Año", isEqualTo: currentPage ) 
                .snapshots()
                .listen((result) {
                result.documents.forEach((result) { 
                  t = result.data['Pago'].toString();

                  total = double.parse(t);
                  
                
                  
                   
                     year += total;
                
                      
                });
          
                  print(year); 
                 
                    
                });

  }
  
  @override
  Widget build(BuildContext context) {
    

   
          
    return Expanded(
      child: Column(
      children: <Widget>[
       _expenses(),
       
          _graph(),
          Container(
                color: Colors.black.withOpacity(0.1),
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
            fontSize: 20.0
          ),
          
        ),
        
        Text("Total de Sueldos por mes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),

       Text("\$${widget.perDay2.toStringAsFixed(2)}", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          ),
          
        ),
        
        Text("Total de Sueldos por dia",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
 
 
          Text("\$${year.toStringAsFixed(2)}", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          ),
          
        ),
       
        
        Text("Total de Sueldos por año",
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
      onTap: (){
       Navigator.of(context).pushNamed("/details3",
            arguments: DetailsPage3(nombre, widget.month));
      },

      leading: Icon(icon, size: 32.0,),
      title: Text(nombre,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0 
        ),
      ),
      subtitle: Text("$percent% de Sueldos",
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
              color:Colors.black,
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
              
              return _item(FontAwesomeIcons.user, key, 100 * data ~/ widget.total, data);
              }, 
            separatorBuilder: (BuildContext context, int index){
              return Container(
                color: Colors.black.withOpacity(0.15),
                height: 8.0,
              );
            },
        ),
    );
  }


  
}


