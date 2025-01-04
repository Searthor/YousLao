import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/cart_item.dart';
import 'package:yous_app/models/order_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/pages/order_page.dart';
import 'package:yous_app/states/scanner_state.dart';
import 'package:yous_app/states/table_state.dart';
import 'package:yous_app/widgets/custom_dialog.dart';

class CartController extends GetxController {
  TableState tableState = Get.put(TableState());
  List<CartItem> cartItems = [];
  var cartCount = 0;
  var cartPrice = 0;
  var isLoading = true;
  final ScannerState scannerState = Get.put(ScannerState());
  Repository repository = Repository();

  void addToCart(CartItem item,int qty) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.product.id == item.product.id);
    if (index != -1) {
      cartItems[index].quantity +=qty;
    } else {
      cartItems.add(item);
    }
    getTotal();
    CustomDialog().showToast(
        text: 'added_to_cart'.tr,
        color: Colors.white,
        backgroundColor: Colors.green);
    update();
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    getTotal();
    update();
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    getTotal();
    update();
  }

  void clearCart() {
    cartItems.clear();
    getTotal();
    update();
  }

  void updateQuantity(CartItem item, int quantity) {
    int index = cartItems.indexOf(item);
    if (index != -1 && quantity > 0) {
      cartItems[index].quantity = quantity;
      // cartItems.refresh();
    } else if (quantity == 0) {
      removeItem(item);
    }
    getTotal();
    update();
  }

  Future<void> createOrder(OrderModel orderModel) async {
    try {
      var body = jsonEncode(orderModel.toJson());
      var res = await repository.post(
        url: '${repository.urlApi}${repository.createOrder}',
        auth: true,
        body: {
          'tableId': orderModel.tableId,
          'cartList': orderModel.cartList,
        },
      );
      if (res != null) {
        if (res.statusCode == 200) {
          var responseBody = jsonDecode(res.body); // Decode the JSON response
          int tableID = responseBody['tableID']; // Extract the tableID
          // print(responseBody['orderdata']);
          int branchID = responseBody['tableID']; // Extract the tableID
          int OrderID = responseBody['orderID']; // Extract the tableID
          scannerState.gettablebyqr(tableID.toString()); 
          tableState.orderID = OrderID.toString();
          clearCart();
          // Optionally show a success message
          CustomDialog().showToast(
              text: 'food_order_completed'.tr,
              color: Colors.white,
              backgroundColor: Colors.green);
        } else {
          print('Failed to create order. Status code: ${res.statusCode}');
          print('Response: ${res.body}');
        }
      }
      if (res.statusCode == 302) {
        CustomDialog().showToast(
            text: 'please_login_first'.tr,
            color: Colors.white,
            backgroundColor: Colors.green);
        Get.to(() => LoginPage(
              Checkorder: 'order',
            ));
      }
      update();
    } catch (e) {
      print('Error: $e');
      update();
    }
  }

  void getTotal() {
    isLoading =true;
    cartCount = 0;
    cartPrice = 0;
    for (var item in cartItems) {
      cartCount += item.quantity;
      cartPrice += int.parse(item.product.price) * item.quantity;
    };
    isLoading =false;
  }
}
