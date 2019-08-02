
class Model {
  String name;
  var price;
  int product_id;
  var picture;
  bool isClicked;

  Model(this.name, this.price, this.product_id,this.picture,this.isClicked);

  set prod_name(String value) => this.name = value; ////////.........??
  String get prod_name => this.name;

  set prod_price(var value1) => this.price = value1;
  String get prod_price => this.price;

  set prod_id(int value5) => this.product_id = value5;
  int get prod_id => this.product_id;

  set prod_picture(var value3) => this.picture = value3;
  String get prod_picture => this.picture;

  set isclicked(bool value4) => this.isClicked = value4;
  bool get isclicked => this.isClicked;


}
