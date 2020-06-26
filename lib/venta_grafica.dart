import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gumen/graph_widget.dart';

class venta_grafica extends StatefulWidget {
  @override
  _venta_graficaState createState() => _venta_graficaState();
}

class _venta_graficaState extends State<venta_grafica> {
  PageController _controller;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,


    );
  }

  Widget _bottomAction(IconData icon){
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ),
        onTap: (){},
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomAppBar(
      notchMargin: 6.0,
      shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.history),
            _bottomAction(FontAwesomeIcons.chartPie),
            SizedBox(width: 48.0,),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        
        onPressed: (){},) ,
        body: _body(),
      
    );
  }

  Widget _body(){
    return SafeArea(//ayuda a trabajar abajo del notch
      child: Column(
        children: <Widget>[
          _selector(),
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



  Widget _pageItem(String nombre, int position){
    var _alignment;

    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );

    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if(position == currentPage){
      _alignment = Alignment.center;
    }

    else if(position > currentPage){
      _alignment = Alignment.centerRight;
    }

    else {
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(nombre,
      style: position == currentPage ? selected : unselected,));
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage){
          setState(() {
            currentPage = newPage;//actualizar el estilo del mes 
          });
        },


        controller: _controller,
      children: <Widget>[
        _pageItem("Enero",0),
        _pageItem("Febrero",1),
        _pageItem("Marzo",2),
        _pageItem("Abril",3),
        _pageItem("Mayo",4),
        _pageItem("Junio",5),
        _pageItem("Julio",6),
        _pageItem("Agosto",7),
        _pageItem("Septiembre",8),
        _pageItem("Octubre",9),
        _pageItem("Noviembre",10),
        _pageItem("Diciembre",11),


       ],
      ),
    );
  }
  
  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text("\$2361,41",
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