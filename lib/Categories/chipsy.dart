import 'package:flutter/material.dart';
import 'model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newproject/drawe.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Chipsy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Chipsy();
  }
}

class _Chipsy extends State<Chipsy> {
    bool _loadInd = true;

  List<Model> ebody;
  List data;
  Model nam;

  String accEmail='';

  getemail(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
accEmail= preferences.getString(key);

setState(() {
  
});
  }
   @override
  void initState() {
      fun();
getemail('email');
    super.initState();
  }


  fun() async {
    data = await getProduct();
    ebody = new List<Model>(data.length);
    //nam = new Model(name, price, picture, isClicked);
    //print(_loadInd);
    for (int i = 0; i < data.length; i++) {
      ebody[i] = new Model(data[i]['name'], data[i]['price'],data[i]['product_id'], data[i]['image'], false);
    //print(data[i]['product_id']);
      //ebody[i]->name ="Ss";

      // ebody[i].name = data[i]['name'];
     // print(ebody[i].name);
    }
    setState(() {
      _loadInd = false;
    });
    //  print(ebody);
    //print(_loadInd);
  }

  likeItem(int i) {
    setState(() {
      if (ebody[i].isClicked) {
        ebody[i].isClicked = false;
      } else {
        ebody[i].isClicked = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          title: new Text('Market'),
          //centerTitle: true,
         
        ),
         backgroundColor: Colors.white,
        drawer: Drawer1(),
      
      body: _buildBody());
  }

  Widget _buildBody() {
    if (_loadInd == true) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: ebody.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
                //height: 100,
                color: Colors.white,
                child: Card(
                  child: InkWell(
                   
                    child: GridTile(
                        footer: Container(
                            color: Colors.white70,
                            child: new Column(
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                              //      Image.asset(),
                                    Text(ebody[i].name),
                                   // Text("${ebody[i].product_id.toString()} LE"),


                                    IconButton(
                                      padding: EdgeInsets.only(left: 40.0),
                                      onPressed: () {
                                        likeItem(i);
                                        if (ebody[i].isClicked == true) {
                                          Post newpost = new Post(
                                           prodname: ebody[i].name,
                                            
                                              );
                                             // print('$newpost newPost');
                                          createPost(
                                              'http://supermarket-robot000.000webhostapp.com/api/add_wish',
                                              newpost.toMap());
                                          Scaffold.of(context)
                                              .showSnackBar(new SnackBar(
                                            content: new Text(
                                                '${ebody[i].name} added to your Wish List'),
                                            duration:
                                                Duration(milliseconds: 500),
                                          ));
                                        }
                                      },
                                      icon: new Icon(ebody[i].isClicked
                                          ? Icons.favorite
                                          : Icons.favorite_border),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 100.0),
                                  child: Text(
                                    '${ebody[i].price.toString()} LE',
                                  ),
                                )
                              ],
                            )),
                        child: Image.asset(
                          ebody[i].picture,width: 100,
                          fit: BoxFit.cover,
                        )),
                  ),
                ));
          });
    }
  }
}

Future<List> getProduct() async {
  String url = 'http://supermarket-robot000.000webhostapp.com/api/get_prod';

  http.Response response = await http.get(url);
  // print('test1');

  return json.decode(response.body);
}

class Post {
  final String prodname;

  Post({this.prodname});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      prodname: json['name']);
     // prodname: json['product_id']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    map["name"] = prodname;

    return map;
  }
}

Future<Post> createPost(String url, Map body) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }

    return Post.fromJson(json.decode(response.body));
  });
}

