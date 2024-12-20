import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/cart_item.dart';
import 'package:yous_app/models/order_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/pages/order_page.dart';
import 'package:yous_app/states/scanner_state.dart';
import 'package:yous_app/widgets/custom_dialog.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var cartCount = 0.obs;
  var cartPrice = 0.obs;
  var isLoading = true.obs;
  final ScannerState scannerState = Get.put(ScannerState());

  Repository repository = Repository();

  void addToCart(CartItem item) {
    isLoading.value = true;
    int index = cartItems
        .indexWhere((cartItem) => cartItem.product.id == item.product.id);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
    getTotal();
    CustomDialog().showToast(
        text: 'added_to_cart'.tr,
        color: Colors.white,
        backgroundColor: Colors.green);
    isLoading.value = false;
  }

  void removeFromCart(CartItem item) {
    isLoading.value = true;
    cartItems.remove(item);
    getTotal();
    isLoading.value = false;
  }

  void removeItem(CartItem item) {
    isLoading.value = true;
    cartItems.remove(item);
    getTotal();
    isLoading.value = false;
  }

  void clearCart() {
    isLoading.value = true;
    cartItems.clear();
    getTotal();
    isLoading.value = false;
  }

  void updateQuantity(CartItem item, int quantity) {
    isLoading.value = true;
    int index = cartItems.indexOf(item);
    if (index != -1 && quantity > 0) {
      cartItems[index].quantity = quantity;
      cartItems.refresh();
    } else if (quantity == 0) {
      removeItem(item);
    }
    getTotal();
    isLoading.value = false;
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
          int branchID = responseBody['tableID']; // Extract the tableID
          scannerState
              .gettablebyqr(tableID.toString()); // Pass tableID as a string
          // int tableID = int.parse(res.body['tableID']);
          // scannerState.gettablebyqr(tableID.toString());
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
    } catch (e) {
      print('Error: $e');
    }
  }

  void getTotal() {
    isLoading.value = true;
    cartCount.value = 0;
    cartPrice.value = 0;
    for (var item in cartItems) {
      cartCount.value += item.quantity;
      cartPrice.value += int.parse(item.product.price) * item.quantity;
    }
    // totalItems = cartItems.length;
    isLoading.value = false;
  }
}
