// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yous_app/models/AllRestaurant_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/profile_page.dart';
import 'package:yous_app/pages/qrscanner.dart';
import 'package:yous_app/pages/restaurant_detail.dart';
import 'package:yous_app/pages/setting_lan_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:yous_app/states/restaurant_states.dart';
import 'package:yous_app/states/slide_controller.dart';
import 'package:yous_app/util/buildNavItem.dart';
import 'package:yous_app/util/restaurants.dart';
import 'package:yous_app/util/review_food.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/widgets/homeslider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppColors appColors = AppColors();
  int currentSlide = 0;
  RestaurantState restaurantState = Get.put(RestaurantState());
  SlideController slideController = Get.put(SlideController());
  AppVerification appVerification = Get.put(AppVerification());
  @override
  void initState() {
    super.initState();
    appVerification.setInitToken();
    restaurantState.fetchRestaurants();
    slideController.getSlides();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appColors.mainColor,
        title: Text(
          'YouSLao',
          style: TextStyle(
              color: appColors.backgroundColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                decoration: BoxDecoration(
                    color: appColors.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingLanPage()));
                  },
                  child: Row(
                    children: [
                      Text(
                        Get.locale?.languageCode == 'la' ? 'LA' : 'EN',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 10),
                      Get.locale?.languageCode == 'la'
                          ? Image.asset(
                              'assets/flags/laos.png', // Path to your default image
                              fit: BoxFit.cover,
                              width: 20,
                            )
                          : Image.asset(
                              'assets/flags/uk.png', // Path to your default image
                              fit: BoxFit.cover,
                              width: 20,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 56.0,
        width: 56.0,
        decoration: BoxDecoration(
          color: appColors.mainColor,
          border: Border.all(color: Colors.white, width: 3.0),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Qrscanner()),
            );
          },
          backgroundColor: Color.fromARGB(0, 235, 17, 17),
          elevation: 0,
          child: Icon(
            Icons.qr_code_scanner,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: appColors.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                BuildNavItem(
                  icon: Icons.home,
                  label: 'home'.tr,
                ),
                BuildNavItem(icon: Icons.reviews, label: 'review'.tr),
              ],
            ),
            Row(
              children: [
                BuildNavItem(
                  icon: Icons.person,
                  label: 'me'.tr,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                BuildNavItem(icon: Icons.help, label: 'report'.tr),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: appColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                HomeSlider(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: appColors.white,
                      border:
                          Border.all(color: Color.fromARGB(115, 214, 225, 255)),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                          color: Color.fromARGB(255, 128, 128, 128),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'search_for_restaurants'.tr,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 90, 90, 90)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'recommended_restaurants'.tr,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 71, 71, 71),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // List of restaurants
                GetBuilder<RestaurantState>(
                  builder: (get) {
                    if (get.isLoading) {
                      return Column(
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
                                  height: 200,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              highlightColor:
                                  Color.fromARGB(157, 214, 214, 214),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 200,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              highlightColor:
                                  Color.fromARGB(157, 214, 214, 214),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: 200,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: get.restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = get.restaurants[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetail(
                                        restaurantId: restaurant.id),
                                  ),
                                );
                              },
                              child: Restaurants(
                                backgroundImg: restaurant.image,
                                name: restaurant.name,
                                menu: restaurant.menu,
                                village: restaurant.village,
                                status: 'close'.tr,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
