import 'package:flutter/material.dart';
import 'drawe.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.blueGrey,
          title: new Text('Market'),
          centerTitle: true,
          
        ),

        // drawer
         backgroundColor: Colors.white,
        drawer:
        
       Drawer1(),
       body: new Container(
         
       ),

      
    );
  }
}