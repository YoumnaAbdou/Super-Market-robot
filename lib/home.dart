import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:newproject/products.dart';
import 'cartTest.dart';
import 'drawe.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Home extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _Home();
//   }
// }

class Home extends  StatelessWidget  {
  
  //final String name;

    clear() async{
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

//  const Home({Key key, this.name}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Widget image_carosal = new Container(
      height: 250,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('image/fish.jpg'),
          AssetImage('image/sandwitch.jpg'),
          AssetImage('image/potato.jpg')
        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 10.0,
      ),
    );
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          title: new Text('Market'),
          centerTitle: true,
          actions: <Widget>[
           
            new IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) => Cart_List()));
              },
            )
          ],
        ),

        // drawer
         backgroundColor: Colors.white,
        drawer:
        
       Drawer1(),
        body: SingleChildScrollView(

         //mainAxisAlignment: MainAxisAlignment.center,
         child: new Column(
   children: <Widget>[
           // Text('$name test',style: TextStyle(fontSize: 50),),
           
            image_carosal,
            Products(),
          ],
         ),
       
        ));
  }
}
// Future<String> getNamepref() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   String name = pref.getString('name');
//   return name;
// }
