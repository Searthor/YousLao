import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/functions/format_price.dart';
import 'package:yous_app/models/order_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:yous_app/states/cart_controller.dart';
import 'package:yous_app/states/order_state.dart';
import 'package:yous_app/models/cart_item.dart';
import 'package:yous_app/util/constants.dart';

class CartPage extends StatefulWidget {
  final int? tableID;
  final int? branchId;
  const CartPage({Key? key, this.tableID, this.branchId}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());
  final OrderState orderState = Get.put(OrderState());

  AppColors appColors = AppColors();
  AppVerification appVerification = Get.put(AppVerification());
  // late bool _isLoading;

  void initState() {
    super.initState();
    cartController.getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text(
          'cart'.tr,
          style: TextStyle(
            color: appColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: appColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: GetBuilder<CartController>(builder: (get) {
          if (get.isLoading) {
            return Text("data");
          } else if (get.cartItems.isEmpty) {
            return Center(child: Text('not_found_product_in_cart'.tr));
          } else {
            return ListView.builder(
              // separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: get.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = get.cartItems[index];
                final tableID = cartItem.tableID;
                final item = cartItem.product;
                final detail = cartItem.details;
                return Column(
                  children: [
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Image.network(
                                    Repository().urlApi + (item.image ?? ''),
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/noimage.jpg', // Path to your default image asset
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${FormatPrice(price: num.parse(item.price.toString() ?? '0'))} ກີບ',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            // top: 5,
                            right: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartController.removeItem(cartItem);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: appColors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cartController.updateQuantity(
                                            cartItem,
                                            cartItem.quantity - 1,
                                          );
                                        },
                                        iconSize: 18,
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      Text(
                                        cartItem.quantity.toString(),
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          cartController.updateQuantity(
                                            cartItem,
                                            cartItem.quantity + 1,
                                          );
                                        },
                                        iconSize: 18,
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 3)
                  ],
                );
              },
            );
          }
        }),
      ),
      bottomSheet: Container(
        height: 200,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(158, 138, 171, 255),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<CartController>(builder: (get) {
              if (get.isLoading) {
                return Text("data");
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "amount".tr,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      get.cartCount.toString() + 'item',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    )
                  ],
                );
              }
            }),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            GetBuilder<CartController>(builder: (get) {
              if (get.isLoading) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "sum_total".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${FormatPrice(price: num.parse(get.cartPrice.toString() ?? '0'))} LAK',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "total".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${FormatPrice(price: num.parse(get.cartPrice.toString() ?? '0'))} LAK',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }
            }),
            const SizedBox(height: 20),
            GetBuilder<CartController>(builder: (get) {
              return ElevatedButton(
                onPressed: cartController.cartItems.length > 0
                    ? () {
                        OrderModel orderModel = OrderModel(
                          userID: 0,
                          tableId: widget.tableID,
                          cartList: cartController.cartItems,
                        );

                        cartController.createOrder(orderModel);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.mainColor,
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: Text(
                  "confirm".tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
