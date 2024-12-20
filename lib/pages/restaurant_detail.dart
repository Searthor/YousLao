import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/AllRestaurant_model.dart';
import 'package:yous_app/states/restaurant_detail_state.dart';
import 'package:yous_app/states/restaurant_states.dart';
import 'package:yous_app/util/constants.dart';
import 'package:yous_app/util/menulist_item.dart';
import 'package:yous_app/widgets/stickyheaderdelegate.dart';

class RestaurantDetail extends StatefulWidget {
  final int? restaurantId;

  const RestaurantDetail({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final RestaurantDetailState restaurantDetailState =
      Get.put(RestaurantDetailState());
  final List<String> _planTypes = [
    'food_list'.tr,
    'review'.tr,
    'map'.tr,
  ];
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch restaurant details and menu
    restaurantDetailState.getRestaurantdetail(widget.restaurantId.toString());
    // restaurantDetailState.getmenu(widget.restaurantId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appColors.backgroundColor,
        body: Obx(() {
          if (restaurantDetailState.isLoading.value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 255, 255, 255),
                    highlightColor: Color.fromARGB(157, 214, 214, 214),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 170,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 255, 255, 255),
                    highlightColor: Color.fromARGB(157, 214, 214, 214),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 100,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 255, 255, 255),
                    highlightColor: Color.fromARGB(157, 214, 214, 214),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 50,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 255, 255, 255),
                    highlightColor: Color.fromARGB(157, 214, 214, 214),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 50,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (restaurantDetailState.getRestaurantlist == null ||
              restaurantDetailState.getRestaurantlist!.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            // Assuming getRestaurantlist returns a list of restaurants, so we take the first one
            final getRestaurant =
                restaurantDetailState.getRestaurantlist!.first;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildTop(getRestaurant),
                ),
                SliverToBoxAdapter(
                  child: _buildContent(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 12),
                ),
                SliverPersistentHeader(
                  delegate:
                      StickyHeaderDelegate(_planTypes, selectIndex, (index) {
                    setState(() {
                      selectIndex = index;
                    });
                  }),
                  pinned: true,
                ),
                // Render menus based on selected index
                if (selectIndex == 0)
                  if (restaurantDetailState.getmenulist.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final menu = restaurantDetailState.getmenulist[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                MenulistItem(
                                  menuName: menu.name ??
                                      '', // Adjust for your actual model
                                  price: menu.price ??
                                      '0', // Adjust for your actual model
                                  image: menu.image ??
                                      'assets/images/foodlaos3.png', // Adjust for your actual model
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                        childCount: restaurantDetailState.getmenulist.length,
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'there_is_no_food_menu_yet.'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                    )
                else if (selectIndex == 1)
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child:  Center(
                        child: Text(
                          'there_are_no_reviews_yet'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ),
                  )
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildTop(getRestaurant restaurant) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(
                Repository().urlApi + restaurant.image.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
                errorBuilder: (context, error, stackTrace) {
                  // Default image to show when the network image fails
                  return Image.asset(
                    'assets/bg.png', // Path to your default image
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 120,
                  );
                },
              ),
            ),
            Positioned(
              top: 150,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 253, 253, 253),
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        restaurant.name ?? '',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      'ບ້ານ ${restaurant.village ?? ''},ເມືອງ ${restaurant.district ?? ''},ແຂວງ ${restaurant.province ?? ''}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    restaurant.phone ?? '',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.house, color: Colors.grey),
                  SizedBox(width: 10),
                  // Text(
                  //   restaurant.isOpen ? 'ເປິດ' : 'ປິດ',
                  //   style: TextStyle(color: restaurant.isOpen ? Colors.green : Colors.red),
                  // ),
                  SizedBox(width: 20),
                  // Row(
                  //   children: List.generate(
                  //     5,
                  //     (index) => Icon(
                  //       index < restaurant.rating ? Icons.star : Icons.star_border,
                  //       color: Color.fromARGB(255, 255, 197, 39),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container();
  }
}
