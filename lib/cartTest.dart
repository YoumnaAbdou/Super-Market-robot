import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Categories/model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart_List extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartList();
  }
}

class _CartList extends State<Cart_List> {
  bool _loadInd = true;

  List<Wish> ebody;
  Wish wish;
  List data;
  Model nam;
  String accEmail = '';
  int total;
  int bill;
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

  fun() async {
    Post newpost = new Post(
      email: accEmail,
    );

    data = await createPost(
        'https://supermarket-robot000.000webhostapp.com/api/get_Cart',
        newpost.toMap());

    ebody = new List<Wish>(data.length);

    for (int i = 0; i < data.length - 1; i++) {
      //  print(data[i]);
      wish = new Wish();
      wish.prodName = data[i]['name'];
      wish.prodPrice = data[i]['price'].toString();
      wish.prodImage = data[i]['image'];
      wish.billId = data[i]['bill_id'];
      // print(wish.billId);

      ebody[i] = wish;
      // total=ebody[i].totalprice;
      //   print(ebody[i].billId);

    }

    total = data[data.length - 1];
    //    print(total);

    setState(() {
      _loadInd = false;
    });
  }
  // billfun() async{
  //    Post1 newpost = new Post1(

  //     billId: accEmail,
  //   );

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          backgroundColor: Colors.blueGrey,
        ),
        body: _wishlist());
  }

  Widget _wishlist() {
    fun();
    // print(wish.billId);
    if (_loadInd == true) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Stack(
        children: <Widget>[
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
            itemCount: ebody.length - 1,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                  height: 90,
                  child: new ListTile(
                    title: new Text(ebody[i].prodName,
                        style: TextStyle(fontSize: 25)),
                    leading: new CircleAvatar(
                      child: new Image.asset(ebody[i].prodImage),
                    ),
                    subtitle: new Text(
                      '${ebody[i].prodPrice.toString()} LE ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int i) => const Divider(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(160, 0, 0, 50),
            child: new SizedBox(
              width: 400,
              height: 50,
              child: new Text(
                '${total.toString()} LE',
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
                  onPressed: () async {
                    Post1 newpost = new Post1(bill_Id: wish.billId);
                    createPost1(
                        'http://supermarket-robot000.000webhostapp.com/api/confirm_bill',
                        wish.billId.toString());
                    Fluttertoast.showToast(
                        msg: "Cart is sending...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 3);
                  }),
            ),
          )
        ],
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
  String prodImage;
  int billId;

  Wish(
      {this.prodId,
      this.prodName,
      this.prodPrice,
      this.prodImage,
      this.billId});

  factory Wish.fromJson(json) {
    return Wish(
        prodName: json['name'],
        prodPrice: json['price'],
        prodImage: json['image'],
        billId: json['bill_id']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    // map['product_id'] = prodId;
    map['name'] = prodName;
    map['price'] = prodPrice;
    map['image'] = prodImage;
    map['bill_id'] = billId;

    return map;
  }
}

Future<List> createPost(String url, Map body) async {
  http.Response response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    Map<String, dynamic> ll = json.decode(response.body);
    List list = new List();
    ll.forEach((f, v) => list.add(v));
    return list;
  } else {}
}

class Post1 {
  int bill_Id;

  Post1({this.bill_Id});

  factory Post1.fromJson(json) {
    return Post1(bill_Id: json['bill_id']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map['bill_id'] = bill_Id;
    return map;
  }
}

Future<Post> createPost1(String url, String body) async {
  http.Response response = await http.post(url, body: {'bill_id': body});
  final int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400 || json == null) {
    throw new Exception("connection Erorr");
  }
  //return http.post(url, body: body).then((http.Response response) {

  //final int statusCode = response.statusCode;

  //if (statusCode < 200 || statusCode > 400 || json == null) {
  //  throw new Exception("asassasasaassasaaaaaaaaaaaaaaaaaaaaa");
  //  }

  //});
}
