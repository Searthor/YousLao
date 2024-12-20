import 'package:get/get.dart';
import 'package:yous_app/models/cart_item.dart';

class OrderModel {
  int? id;
  int? tableId;
  int? userID;
  List<CartItem> cartList;

  OrderModel({
    this.id,
    required this.tableId,
    required this.userID,
    required this.cartList,
  });
  
  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tableId = json['tableId'],
        userID = json['userID'],
        cartList = (json['cartList'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tableId': tableId,
      'userID': userID,
      'cartList': cartList.map((item) => item.toJson()).toList(),
    };
  }
}