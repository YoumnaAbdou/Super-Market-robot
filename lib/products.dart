import 'package:flutter/material.dart';
//import 'package:newproject/Categories/chicken.dart';
import 'package:newproject/Categories/chipsy.dart';
import 'package:newproject/Categories/drinks.dart';
import 'package:newproject/Categories/grains.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:newproject/Categories/testProd.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Products();
  }
}

class _Products extends State<Products> {
  //------------------------- List of Categories ---------------------------------------
  var Product_List = [
    {
      "name": "Meats",
      "picture": "image/chicken.jpg",
    },
    {
      "name": "Grains",
      "picture": "image/grains.jpg",
    },
    {
      "name": "Drinks",
      "picture": "image/drinks.jpg",
    },
    {
      "name": "Snaks",
      "picture": "image/chipsy.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: new GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: Product_List.length,
      
        itemBuilder: (BuildContext context, int index) {
          return prodSetting(
            prod_name: Product_List[index]['name'],
            prod_picture: Product_List[index]['picture'],
          );
        },
      ),
    );
  }
}

class prodSetting extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final String email;

  prodSetting({Key key, this.prod_name, this.prod_picture, this.email});
  void fun() async {
    List data = await getProduct();
    for (int i = 0; i < data.length; i++) {
      print(data[i]['name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    void checked() {
      if (prod_name == 'Meats') {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) => Test()));
       }
       else if (prod_name == 'Grains') {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) => Grains()));
       }
      else if (prod_name == 'Drinks') {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) => Drinks()));
      } else if (prod_name == 'Snaks') {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) => Chipsy()));
      }
    }

    return Card(
      child: InkWell(
        onTap: checked,
        child: GridTile(
            footer: Container(
                height: 30,
                color: Colors.grey[350],
                child: new Column(
                  children: <Widget>[
                    Text(
                      prod_name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )),
            child: Image.asset(
              prod_picture,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

Future<List> getProduct() async {
  String Url = 'http://supermarket-robot000.000webhostapp.com/api/get_prod';
  http.Response response = await http.get(Url);
  print('test1');
  return json.decode(response.body);
}
