import 'package:yous_app/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int tableID;
  int quantity; // Make quantity non-final for mutability
  List<int> details; // Specify the type as List<int>

  CartItem({
    required this.product,
    required this.tableID,
    this.quantity = 1,
    this.details = const [],
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      tableID: json['tableID'],
      details: List<int>.from(json['details'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'productId': product.id,
      'table': tableID,
      'details': details,
    };
  }
}
