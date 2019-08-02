import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Categories/model.dart';
import 'package:newproject/payment.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _loadInd = true;

  List<Wish> ebody;
  List data;
  Model nam;
  String accEmail = '';
    int _itemCount = 1;
//  int price=30;
  int nprice=0 ;

  getemail(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accEmail = preferences.getString(key);

    setState(() {});
  }


  @override
  void initState() {
    getemail('email');
    super.initState();
  }



  fun() async{
      Post newpost = new Post(
     
      email: accEmail,
    );
    data = await createPost('https://supermarket-robot000.000webhostapp.com/api/get_wish',
               newpost.toMap());
    
    ebody = new List<Wish>(data.length);
    //nam = new Model(name, price, picture, isClicked);
   // print(data);
    for (int i = 0; i < data.length; i++) {
      
      //print(data[i]['product_id']);
      Wish wish = new Wish();
      wish.prodId = data[i]['product_id'];
      ebody[i] = wish;

    }
       setState(() {
      _loadInd = false;
    });
  // print(ebody[0].prodId);

  }

  @override
  Widget build(BuildContext context) {
    fun();
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: _build());
  }

  Widget _build() {
    if (_loadInd == true) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Stack(
        children: <Widget>[
          ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemCount: ebody.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                  height: 90,

                  //color: Colors.amber[colorCodes[index]],
                  child: new ListTile(
                      title: new Text(ebody[i].prodId.toString()),
                      leading: new CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                      subtitle: new Row(
                        children: <Widget>[
                          Text('{(nprice-ebody[i].price).toString()}'),
                          _itemCount != 0
                              ? new IconButton(
                                  icon: new Icon(Icons.remove),
                                  onPressed: () => setState(() {
                                //  if (ebody[i].isClicked == true) {
                                //     print(ebody[i].price);

                                //         _itemCount--;
                                //         nprice =nprice-(ebody[i].price);
                                //       }
                                }
                                ),
                                )
                              : new Container(),
                          new Text(_itemCount.toString()),
                          new IconButton(
                              icon: new Icon(Icons.add),
                              onPressed: () => setState(() {
                               // likeItem(i);
                                //  if (ebody[i].isClicked == true) {
                                //     print(ebody[i].price);
                                // _itemCount++;
                                //     nprice = (ebody[i].price) * _itemCount;
                                //    // print(nprice);
                                //   }
                                  })),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          )
                        ],
                      )));
              // return ListTile(
                              
              // );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(60, 0, 0, 50),
            child: new SizedBox(
              width: 400,
              height: 50,
              child: new Text(
                '{(nprice * entries.length).toString()} LE',
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 0),
            child: new SizedBox(
              width: 300,
              height: 50,
              child: new FlatButton(
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 15),
                  ),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => Payment()));
                  }),
            ),
          )
        ],
      );
    }
  }
}

// Future<List> getProduct() async {
//   String Url = 'https://supermarket-robot000.000webhostapp.com/api/get_Cart';

//   http.Response response = await http.get(Url);
//   // print('test1');

//   return json.decode(response.body);
// }


class Post {
  final String email;

  Post({this.email});

  factory Post.fromJson(json) {
    return Post(email: json['mail']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['mail'] = email;
    return map;
  }
}

class Wish {
  int prodId;


  Wish({this.prodId});

  factory Wish.fromJson(json) {
    return Wish(prodId: json['product_id']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    map['product_id'] = prodId;

    return map;
  }
}

Future<List> createPost(String url, Map body) async {


  http.Response response =
      await http.post(url, body:body);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    //print(json.decode(response.body));
    Map<String, dynamic> ll = json.decode(response.body);
    List list = new List() ; 
    ll.forEach((f,v) => list.add(v));
    print(list[1]['product_id']);
    return list;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}