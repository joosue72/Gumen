import 'package:flutter/material.dart';
import 'Menu.dart';
import 'Nomina.dart';
import 'DetallesNomina.dart';
import 'NombresNomina.dart';

 class MenuNominas extends StatefulWidget {
  MenuNominas({Key key}) : super(key: key);

  @override
  _MenuNominasState createState() => _MenuNominasState();
}

bool _debugLocked = false;

class _MenuNominasState extends State<MenuNominas> {
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
                            
                            child: Ink.image(image: AssetImage('images/nomina2.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => Nomina());
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
                            
                            child: Ink.image(image: AssetImage('images/nomina3.png'), height: 100, alignment: Alignment.center, 
                           ) , 

                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => NombresNomina());
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
                            
                            child: Ink.image(image: AssetImage('images/nomina4.png'), height: 100, alignment: Alignment.center, 

                            
                           ) , 
                            
                            
                             onPressed: (){
                               
                               Route route = MaterialPageRoute(builder: (bc) => DetallesNomina());
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