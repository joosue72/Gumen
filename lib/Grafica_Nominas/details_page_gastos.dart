
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage3{
  final String categoryName;
  final int month;

  DetailsPage3(this.categoryName, this.month);
}

class DetailsParams3 extends StatefulWidget {
  final DetailsPage3 params;

  const DetailsParams3({Key key, this.params}) : super(key: key);
  @override
  _DetailsParams3State createState() => _DetailsParams3State();
}

class _DetailsParams3State extends State<DetailsParams3> {
  @override
  Widget build(BuildContext context) {

     var _query = Firestore.instance
                .collection('Nomina')
                .where("Mes", isEqualTo: widget.params.month + 1)
                .where("Empleado", isEqualTo: widget.params.categoryName.toString())
                .snapshots();

    return Scaffold(
     appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
           title: Text("Descripción"),
        backgroundColor: Colors.orange[700]
        ),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _query,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data){
          if(data.hasData)
          {
            return ListView.builder(
              itemBuilder: (BuildContext context,int index){
                var document = data.data.documents[index];

                return Dismissible(
                  key: Key(document.documentID),
                  onDismissed: (direction){
                    Firestore.instance
                      .collection('Nomina')
                      .document(document.documentID)
                      .delete();

                  },
                    child: ListTile(
                   leading: Stack(
               
                     children: <Widget>[
                       
                       Icon(Icons.calendar_today,size: 40,),
                       Positioned(
                         left: 0,
                         right: 0,
                         bottom: 8,
                         child: Text(document["Dia"].toString(), textAlign: TextAlign.center,), 
                         ),
                   ],),
                   title:Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("\ ${document["Empleado"]}",
                                    style: TextStyle(
                                      color:Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0,
                              ),
                           ),
                       )
        
                     ),
      

                  ),
                );
            },
              itemCount: data.data.documents.length,
            );
          }

          return Center(child: CircularProgressIndicator()
          );
        },

        )
       
    );
  }

  
}


