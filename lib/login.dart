import 'package:flutter/material.dart';
import 'package:newproject/home.dart';
import 'package:newproject/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  //controllers of texts
  final TextEditingController mail = new TextEditingController();
  final TextEditingController pass = new TextEditingController();

  String _savedData = "";
  bool _loadInd = true;
  String mess;
  String accName = '';

  saveMessage(mess) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('email', mess);
    _savedData = preferences.getString('email');

    print(_savedData);
    // print(_saveMessage(message));
  }

  getname(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accName = preferences.getString(key);

    setState(() {});
  }

  @override
  void initState() {
    getname('name');
    super.initState();
  }

  //function of SignUp
  void signUpfunction() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  //function of SignUp
  Future<List> login() async {

 
    if (mail.text.trim().isEmpty && pass.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter mail or password correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
    } else {
      final responce = await http.post(
          "http://supermarket-robot000.000webhostapp.com/api/login",
          body: {"mail": mail.text, "password": pass.text});

      print(responce.body);
      if (responce.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "You Must Signup First",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 3);
        print("test1");
      } 
      else {
        saveMessage(mail.text);
        getname('name');
        //  mess=mail.text;

        //  mess=mail.text;
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (BuildContext context) => Home()));

      }
         setState(() {
      _loadInd = false;
    });
    
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[
         
              new Column(
               
                  children: <Widget>[
                   new Container(
                    padding: EdgeInsets.only(top: 320),
                     child:new TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      controller: mail,
                      decoration: new InputDecoration(
                        hintText: 'Email',
                        icon: new Icon(
                          Icons.account_circle,
                          size: 30.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ), 
                   ),
                    
                    Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    new TextField(
                      obscureText: true,
                      controller: pass,
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      decoration: new InputDecoration(
                        hintText: 'Password',
                        
                        icon: new Icon(
                          Icons.lock,
                           size: 30.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  
                    new Container(
                      padding: EdgeInsets.only(top: 20),
                      width: 300.0,
                      child: new FlatButton(
                        onPressed: () {
                          print('pressd1');
                      
                          login();
                        },
                        child: new Text('LogIn',style: TextStyle(fontSize: 18)),
                        textColor: Colors.white,
                        color: Colors.blueGrey,
                      ),
                    ),
                    new SizedBox(
                      width: 300.0,
                      child: new FlatButton(
                        onPressed: signUpfunction,
                        child: new Text('SignUp',style: TextStyle(fontSize: 18)),
                        textColor: Colors.white,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
         
          ],
        ),
      ),
    );
  }
}
