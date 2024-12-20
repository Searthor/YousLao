import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/functions/format_price.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/cart_page.dart';
import 'package:yous_app/pages/first_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/order_state.dart';
import 'package:yous_app/states/cart_controller.dart'; // Import the CartController
import 'package:yous_app/models/cart_item.dart'; // Import the CartItem
import 'package:badges/badges.dart' as badges;
import 'package:yous_app/states/product_state.dart';
import 'package:yous_app/states/scanner_state.dart';

class OrderPage extends StatefulWidget {
  final int? tableID;
  final int? branchId;

  const OrderPage({Key? key, required this.tableID, required this.branchId})
      : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final ProductState productState = Get.put(ProductState());
  final CartController cartController = Get.put(CartController());
  final ScannerState scannerState = Get.put(ScannerState());

  AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    productState.getmenu(widget.branchId.toString());
    cartController.getTotal();
  }

   Future<void> _refreshData() async {
    await getData();
  }


  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    double fSize = sizes.width + sizes.height;
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text(
          'food_list'.tr,
          style: TextStyle(color: appColors.white,fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(
                            tableID: widget.tableID,
                            branchId: widget.branchId,
                          )),
                );
              },
              child: badges.Badge(
                badgeContent: Obx(() {
                  return Center(
                    child: Text(
                      '${cartController.cartItems.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                animationDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: appColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                indicatorColor: appColors.mainColor,
                labelColor: appColors.mainColor,
                unselectedLabelStyle: TextStyle(fontSize: 15),
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    text: 'food'.tr,
                  ),
                  Tab(
                    text: 'drink'.tr,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    Obx(() {
                      if (productState.isLoading.value) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Center(
                                child: Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  highlightColor:
                                      Color.fromARGB(157, 214, 214, 214),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 60,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  highlightColor:
                                      Color.fromARGB(157, 214, 214, 214),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: 60,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return  RefreshIndicator(
                          onRefresh: _refreshData,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: productState.getmenufoodlist.length,
                            itemBuilder: (context, index) {
                              final item = productState.getmenufoodlist[index];
                              return _buildListItem(item);
                            },
                          ),
                        );
                      }
                    }),
                    Obx(() {
                      if (productState.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (productState.getmenudrinklist.isEmpty ||
                          productState.getmenudrinklist == null) {
                        return Center(child: Text('there_is_no_food_menu_yet'.tr));
                      } else {
                        return RefreshIndicator(
                          onRefresh: _refreshData,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: productState.getmenudrinklist.length,
                            itemBuilder: (context, index) {
                              final item = productState.getmenudrinklist[index];
                              return _buildListItem(item);
                            },
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
              Obx(() {
                if (scannerState.gettabeData.isNotEmpty &&
                    scannerState.gettabeData[0].status == 2) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: appColors.backgroundColor,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: SizedBox(
                                height: 350,
                                child: ListView.builder(
                                  itemCount:
                                      scannerState.gettabeOrderData.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        scannerState.gettabeOrderData[index];
                                    return _buildOrderListItem(item);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: appColors.mainColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Center(
                          child: Text(
                            "ordered_items".tr,
                            style: TextStyle(
                                color: appColors.backgroundColor, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Text("");
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 15, bottom: 5),
              width: double.infinity,
              height: 60,
              color: Colors.white, // Replace with appColors.white if defined
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          Repository().urlApi + (item.image ?? ''),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/noimage.jpg', // Path to your default image asset
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            item.name ?? 'Unknown',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${FormatPrice(price: num.parse(item.price ?? '0'))} LAK',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // _addToCart(item);
                      cartController.addToCart(CartItem(
                          product: item,
                          tableID: widget.tableID ?? 0,
                          userID: 4));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: Colors.blue,
                        child: Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildOrderListItem(dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 15, bottom: 5),
              width: double.infinity,
              height: 60,
              color: Colors.white, // Replace with appColors.white if defined
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          Repository().urlApi + (item.image ?? ''),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/noimage.jpg', // Path to your default image asset
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            item.name ?? 'Unknown',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${FormatPrice(price: num.parse(item.price ?? '0'))} LAK',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text('x ${item.qty.toString()}')
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
