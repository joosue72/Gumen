import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class editar_meta extends StatefulWidget {
  @override
  _editar_metaState createState() => _editar_metaState();
}

 String t ; double total;

class _editar_metaState extends State<editar_meta> {
GlobalKey<RefreshIndicatorState> refreshKey;
   final db = Firestore.instance;
 
  final _controller = TextEditingController();
  String name = "";
  TextEditingController meta = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    traermeta();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          title: Text('Lista de Ventas'),
        backgroundColor: Colors.orange
        ),
        
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async{
         setState(() { traermeta(); });
        }, 
        child:ListView(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(name),
          _expenses2(),
          Container(
            
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: meta,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.orangeAccent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.edit),
                 hintText: "Editar Meta",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            ),
            padding: EdgeInsets.all(32),
            ),
            

          Container(

            width: double.infinity,
            child: FlatButton(
              
              child: Text("Editar"),
              color: Colors.orangeAccent,
              
              onPressed: (){
                Firestore.instance.collection("Meta").document('J8LlpZ35rNvcL8EaSdrd').updateData({'Valor': meta.text});
              },
            ),
            padding: EdgeInsets.all(32),
            alignment: Alignment.bottomRight,

            
          )
          

        ],)
        ),
      
    );
  }


  void traermeta(){

        
          db
          .collection("Meta")
          .snapshots()
          .listen((result) {
        result.documents.forEach((result) {
          t = result.data['Valor'].toString();
            total = double.parse(t);

      
        });
              
        });

        

     }


    Widget _expenses2() {
   
    return Column(
      children: <Widget>[
        
        Text("\$${total}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Meta",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}