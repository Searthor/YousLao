import 'package:yous_app/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int tableID;
  int userID;
  int quantity;  // Make quantity non-final

  CartItem({
    required this.product,
    required this.tableID,
    required this.userID,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      tableID: json['tableID'],
      userID: json['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'productId': product.id,
      'table': tableID,
      'userID': userID,
    };
  }
}
