import 'package:flutter/material.dart';
 
import 'Categories/model.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int billId=0;
  bool _loadInd = true;
//  int price=30;
  int nprice=0;
    List<Model> ebody;
  List data;

  //   fun() async {
  //   data = await getProduct();
  //   ebody = new List<Model>(data.length);

  //   for (int i = 0; i < data.length; i++) {
  //     ebody[i] = new Model(data[i]['name'], data[i]['price'],data[i]['product_id'], "", false);
  
  //   }
  //   setState(() {
  //     _loadInd = false;
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:new Container(
        child: new Column(
          children: <Widget>[
            Text('Your order Id $billId',style: TextStyle(fontSize: 20,color: Colors.black,)),
            new Container(
                  height: 44.0,
                  child: new ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                     Text('test1'),
                     Text('tet2')
    ],
  ),
)

          ],
        ),
      ) ,
    );
  }
}

// Future<List> getProduct() async {
//   String Url = 'http://supermarket-robot000.000webhostapp.com/api/get_prod';

//   http.Response response = await http.get(Url);
//   // print('test1');

//   return json.decode(response.body);
// }