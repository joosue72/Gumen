
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumen/Empleados.dart';
import 'package:gumen/Gastos.dart';
import 'package:gumen/MenuGraficas.dart';
import 'package:gumen/Meta/Grafica_Meta.dart';
import 'Meta/Ganancias.dart';
import 'Ventas.dart';
import 'VentasPendientes.dart';
import 'Gastos.dart';
import 'Inventario.dart';
import 'MenuProveedores.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool _debugLocked = false;

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  

  double getRadiansFromDegree(double degree)
  {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
      }

  

  @override
  Widget build(BuildContext context) {
    assert(!_debugLocked);
    
    // to get size
    var size = MediaQuery.of(context).size;
    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        
        color: Color.fromRGBO(63, 63, 63, 1));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(

        
        
        children: <Widget>[
         
         

          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

             gradient: new LinearGradient(colors: [const Color(0xFFFFC107), const Color(0xFFFFE57F)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
                
             
             
             )
            ),
          ),
           
          
          SafeArea(
            
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 84,
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Color(0xFFFFC107),
                          backgroundImage: AssetImage(
                              'assets/logogumen3.png'),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                       
                      ],
                    ),
                  ),
                  Expanded(
                    
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                              shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFFFFC107),
                            
                            child: Ink.image(image: AssetImage('images/carrito1.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Ventas());
                               Navigator.of(context).push(route);
                              
                             },
                            ),

                           
                          
                        ),

                        Card(
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFFFFD600),
                            
                            child: Ink.image(image: AssetImage('images/pendientes.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               Navigator.of(context).push(route);
                              
                             },
                            ),

                           
                          
                        ),
                        

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFFF57F17),
                            
                            child: Ink.image(image: AssetImage('images/nomina1.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Empleados());
                               Navigator.of(context).push(route);
                              
                             },
                             
                            ),
                            
                            
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFFF50057),
                            
                            child: Ink.image(image: AssetImage('images/stat.png'), height: 100, alignment: Alignment.center, 

                            
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => MenuGrafica());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFF00BCD4),
                            
                            child: Ink.image(image: AssetImage('images/gasto.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Gastos());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),

                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFF0FF1714),
                            

                            child: Ink.image(image: AssetImage('images/inventario.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Inventario());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Color(0xFF64DD17),
                            
                            child: Ink.image(image: AssetImage('images/proveedor.png'), height: 100, alignment: Alignment.center, 
                           ) , 
                            
                            
                             onPressed: (){
                             Route route = MaterialPageRoute(builder: (bc) => MenuProveedor());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                        ),
                        Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/meta.png'), height: 100, alignment: Alignment.center, 

                           ) , 
                            
                            
                             onPressed: (){

                    
                               
                               Route route = MaterialPageRoute(builder: (bc) => Meta());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),
                         Card(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                          child: RaisedButton(
                             shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          elevation: 4,
                            color: Colors.white,
                            
                            child: Ink.image(image: AssetImage('images/meta.png'), height: 100, alignment: Alignment.center, 

                           ) , 
                            
                            
                             onPressed: (){

                    
                               
                               Route route = MaterialPageRoute(builder: (bc) => Ganancias());
                               Navigator.of(context).push(route);
                              
                             },
                            ),
                           
                        ),

                       
                      ],
                    ),
                  ),
                ],
              ),  
            ),
          ),
        ],
      ),
    );
  }
 
}


class CircularButton extends StatelessWidget {
 final double width;
 final double height;
 final Color color;
 final Icon icon;
 final Function onClick;

  const CircularButton({Key key, this.width, this.height, this.color, this.icon, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon,enableFeedback: true, onPressed: onClick),
      
    );
  }
}
