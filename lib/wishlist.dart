import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Categories/model.dart';



class Wish_List extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WishList();
  }
}

class _WishList extends State<Wish_List> {
  bool _loadInd = true;

  List<Wish> ebody;
  List data;
  Model nam;
  String accEmail = '';

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
    print(newpost);
    data = await createPost('https://supermarket-robot000.000webhostapp.com/api/get_wish',
               newpost.toMap());
    print(data);
    ebody = new List<Wish>(data.length);
    //nam = new Model(name, price, picture, isClicked);
    // print("ddddddddddddddddddddddddddddddddddddddddddddddddddd");
     
    for (int i = 0; i < data.length; i++) {
      
      //print(data[i]['product_id']);
      Wish wish = new Wish();
      wish.prodName = data[i]['name'];
      wish.prodId = data[i]['product_id'];
       wish.prodPrice = data[i]['price'];
      ebody[i] = wish;

    }
       setState(() {
      _loadInd = false;
    });
  // print(ebody[0].prodId);

  }
   @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
        appBar: AppBar(
          title: Text('My Wish List'),
          backgroundColor: Colors.blueGrey,
        ),
        body: _wishlist());
  }

  Widget _wishlist() {
    fun(); 
       if(_loadInd==true){
 return new Center(
        child: new CircularProgressIndicator(),
      );

      }
      else{
    return new Container(
        child:
        
      // By default, show a loading spinner.
  //     return CircularProgressIndicator();
  // },
  //)  
        ListView.separated(
          padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
          itemCount: ebody.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
                height: 90,
                child: new ListTile(
                    title: new Text(ebody[i].prodName),
                    leading: new CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    subtitle: new Row(
                      children: <Widget>[
                        Text(ebody[i].prodPrice.toString()),
                        new Text(''),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: (){
                            cart newpost = new cart(
                                          email: accEmail,
                                          prodId: ebody[i].prodId.toString()                                       
                                              );
                                             // print('$newpost newPost');
                                          createPostCart(
                                              'http://supermarket-robot000.000webhostapp.com/api/add_toCart',
                                              newpost.toMap());
                                          Scaffold.of(context)
                                              .showSnackBar(new SnackBar(
                                            content: new Text(
                                                '${ebody[i].prodName} added to your Cart'),
                                            duration:
                                                Duration(milliseconds: 500),
                                          ));
                          },
                        )
                        // IconButton(
                        //   alignment: Alignment(30, 0),
                        //   icon: Icon(Icons.shopping_cart),
                        //   onPressed: () {
                        //     // print('pressed cart');
                               
                        //     //               Wish newpost = new Wish(
                                          
                                            
                        //     //                   );
                        //     //                  // print('$newpost newPost');
                        //     //               createPost(
                        //     //                   'http://supermarket-robot000.000webhostapp.com/api/add_toCart',
                        //     //                   newpost.toMap());
                        //                   Scaffold.of(context)
                        //                       .showSnackBar(new SnackBar(
                        //                     content: new Text(
                        //                         ' added to your Wish List'),
                        //                     duration:
                        //                         Duration(milliseconds: 500),
                        //                   ));
                                        
                           
                        //   },
                        // )
                      ],
                    )));
      
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      );
    }
  
      }
     
    
  
}


class Post {
  String email;

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
  String prodName;
  String prodPrice;


  Wish({this.prodId,this.prodName,this.prodPrice});

  factory Wish.fromJson(json) {
    return Wish(
      prodId: json['product_id'],
      prodName: json['name'],
      prodPrice: json['price'],

      );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    map['product_id'] = prodId;
    map['name'] = prodName;
    map['price'] = prodPrice;

    return map;
  }
}

Future<List> createPost(String url, Map body) async {
  print(body);
  http.Response response =
      await http.post(url, body:body);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print(json.decode(response.body));
    print("-----------------------------------------------------");
    print(json.decode(response.statusCode.toString()));
    print("-----------------------------------------------------");
    
    List ll = json.decode(response.body);
    print(ll);
    //ll.forEach((f,v) => list.add(v));
   // print(list[1]['product_id']);
    return ll;
   //Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    print("ssssssssssssssssssssss");
     throw new Exception("Error while fetching data");
    //throw Exception('succes');
  }
}


class cart {

  final String prodId,email;

  cart({this.prodId,this.email});

  factory cart.fromJson(Map<String, dynamic> json) {
    return cart(
       email: json['mail'],
       prodId: json['product_id']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    map['mail'] = email;
    map['product_id']=prodId;

    return map;
  }
}

Future<cart> createPostCart(String url, Map body) async {
  
  print("-----------------------sfgdfdgd------------------------------");
  print(body);
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    print(body);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      print('error');
      throw new Exception("Error while fetching data");
    }
    
  print('enterd');
    return cart.fromJson(json.decode(response.body));
  });
}


