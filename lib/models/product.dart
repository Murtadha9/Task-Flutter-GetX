
class Product {
  Product(this.id, this.name, this.price, this.orderNo, this.qty);

  final int id;
  late String name;
  late String price;
  late String orderNo;
  late int qty;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'orderNo': orderNo,
      'qty': qty,
    };
  }

 
  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'],
      map['name'],
      map['price'],
      map['orderNo'],
      map['qty'],
    );
  }
}
