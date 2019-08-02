import 'package:flutter/material.dart';
import 'package:newproject/home.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  final Future<Post> post;

  SignUp({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUp> {
  final TextEditingController mail = new TextEditingController();
  final TextEditingController pass = new TextEditingController();
  final TextEditingController firstname = new TextEditingController();
  final TextEditingController secondname = new TextEditingController();
  
  String _savedData='';
 
 
  
  saveMessage( mess) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('name', mess);
        _savedData = preferences.getString('name');
     
     print(_savedData);
    // print(_saveMessage(message));
  }



  void signup() {
    if (mail.text.trim().isEmpty ||
        secondname.text.trim().isEmpty ||
        pass.text.trim().isEmpty ||
        firstname.text.trim().isEmpty) {
       Fluttertoast.showToast(
          msg: "Enter mail or password correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
    } else {
       saveMessage(firstname.text);
       
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false, //preventing collapse keyboard
      body: new Container(
        padding: EdgeInsets.only(bottom: 50),
        //alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             new Container(
                //  width: ScreenUtil.getInstance().setWidth(300),
                // height: ScreenUtil.getInstance().setWidth(300),
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                 //   new Image.asset('image/chickens/shopping.jpg',width: 300,height: 300,alignment: Alignment(0, -10),),
                    new Container(
                       child:   new TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                      controller: firstname,
                      decoration: new InputDecoration(
                        

                        hintText: 'Your First name',
                        icon: new Icon(Icons.account_circle,
                            color: Colors.blueGrey, size: 30.0,),
                      ),
                    ),

                    ),

                new Container(
                  padding: EdgeInsets.only(top: 20),
                  child: new TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                      controller: secondname,
                      decoration: new InputDecoration(
                        hintText: 'Your Second name',
                        icon: new Icon(Icons.account_circle,
                            color: Colors.blueGrey,
                            size: 30.0,),
                      ),
                    ),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 20),
                  child:  new TextField(
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: mail,
                      decoration: new InputDecoration(
                        hintText: 'Your Email',
                        icon: new Icon(Icons.mail, color: Colors.blueGrey, size: 30.0,),
                      ),
                    ),
                ),
              new Container(
              padding: EdgeInsets.only(top: 20),

                child:  new TextField(
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                      obscureText: true,
                      controller: pass,
                      decoration: new InputDecoration(
                        hintText: 'Password',
                        icon: new Icon(
                          Icons.lock,
                          color: Colors.blueGrey,
                           size: 30.0,
                        ),
                      ),
                    ),
              ),
                   
                  ],
                ),
              ),
            
            new Card(
              child: new Container(
                padding: EdgeInsets.only(top: 40),
                child: new Column(
                  children: <Widget>[
                    new SizedBox(
                      width: 300,
                     // height: 50,
                      child: new FlatButton(
                        onPressed: () async {
                          print('pressed 1');
                          Post newpost = new Post(
                              fname: firstname.text,
                              sname: secondname.text,
                              email: mail.text,
                              password: pass.text
                              );
                          createPost('http://supermarket-robot000.000webhostapp.com/api/signup',
                              newpost.toMap()
                              );
                          return signup();
                        },
                        child: new Text('SignUp',style: TextStyle(fontSize: 18),),
                        textColor: Colors.white,
                        color: Colors.blueGrey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Post {
  final String fname, sname, email, password;

  Post({this.fname, this.sname, this.email, this.password});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        fname: json['fname'],
        sname: json['sname'],
        email: json['mail'],
        password: json['password']);
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["fname"] = fname;
    map["sname"] = sname;
    map["mail"] = email;
    map["password"] = password;

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
