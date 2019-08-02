
import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'cartTest.dart';
import 'package:newproject/wishlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Drawer1 extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<Drawer1> {
String accEmail='';
String accName='';
 getemail(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
accEmail= preferences.getString(key);

setState(() {
  
});
  }
   getname(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
accName= preferences.getString(key);

setState(() {
  
});
  }
   @override
  void initState() {
getname('name');
getemail('email');
    super.initState();
  }


  clear() async{
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
     
        child:  new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text('Youmna'),
                accountEmail: Text('$accEmail '),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (BuildContext context) => Home()));
                },
                child: ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.home),
                ),
              ),
              
              InkWell(
                onTap: () {Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) => Cart_List()));},
                child: ListTile(
                  title: Text(
                    'My Orders',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.add_shopping_cart),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => Wish_List()));
                },
                child: ListTile(
                  title: Text(
                    'Wish List',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.list),
                ),
              ),
              Divider(),
             
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text(
                    'About',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.help),
                ),
              ),
              InkWell(
                onTap: () {
            //
              Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Login()),
                    (Route<dynamic> route) => false);
                     clear() ;
                },
                child: ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.exit_to_app),
                ),
              ),
            ],
          ),
          
    );
      
   
  }
}

class Post {
  final String email;

  Post({this.email});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(email: json['mail']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();

    map['mail'] = email;

    return map;
  }
}

Future<Post> createPost(String url, Map body) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      print('error');
      throw new Exception("Error while fetching data");
    }

    print('enterd');
    return Post.fromJson(json.decode(response.body));
  });
}