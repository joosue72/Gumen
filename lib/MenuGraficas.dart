import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gumen/Grafica_Gastos/venta_grafica_gastos.dart';
import 'package:gumen/Menu.dart';
import 'Grafica_Nominas/venta_grafica_gastos.dart';
import 'Grafica_Ventas/venta_grafica.dart';
import 'Meta/Ganancias.dart';



 class MenuGrafica extends StatefulWidget {
  MenuGrafica({Key key}) : super(key: key);

  @override
  _MenuGraficaState createState() => _MenuGraficaState();
}

bool _debugLocked = false;

class _MenuGraficaState extends State<MenuGrafica> with SingleTickerProviderStateMixin{

 

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
                              child: Visibility( 
                              child: IconButton( icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
    
  );

        }),
        maintainInteractivity: true,
        maintainSize: true, 
  maintainAnimation: true,
        maintainState: true,
        visible: false,
        ),   
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
                            color: Color(0xFFF57F17),
                            
                            child: Ink.image(image: AssetImage('images/stat4.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => venta_grafica3());
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
                            
                            child: Ink.image(image: AssetImage('images/stat3.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => venta_grafica2());
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
                            color: Color(0xFFFFC107),
                            
                            child: Ink.image(image: AssetImage('images/stat2.png'), height: 100, alignment: Alignment.center, 

                            
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => venta_grafica());
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
                            
                            child: Ink.image(image: AssetImage('images/stat5.png'), height: 100, alignment: Alignment.center, 

                            
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