import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cart.dart';

class item_detail extends StatelessWidget {
  final String text;
  final String name;
  final String price;

  buy() {
    Fluttertoast.showToast(
        msg: "Product added to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3);
  }

  const item_detail({Key key, this.text, this.name, this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Text('Market'),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (BuildContext context) => Cart()));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    new BoxShadow(color: Colors.white70, blurRadius: 20.0)
                  ]),
                  child: Image.asset(name, width: 300),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                  // alignment: Alignment.centerRight,
                  child: Text(price,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                ),
                //   ],
                // ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    )),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 20),
            child: new SizedBox(
              width: 400,
              height: 50,
              child: new FlatButton(
                  child: Text(
                    'Buy now',
                    style: TextStyle(fontSize: 20),
                  ),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: buy),
            ),
          )
        ],
      ),
    );
  }
}
