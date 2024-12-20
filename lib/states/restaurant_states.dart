// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:yous_app/models/AllRestaurant_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/test.dart';

class RestaurantState extends GetxController {
  var restaurants = <AllRestaurantModel>[].obs;
  var isLoading = true.obs;

  Repository repository = Repository();

  @override
  void onInit() {
    fetchRestaurants();
    super.onInit();
  }

  Future<void> fetchRestaurants() async {
    try {
       isLoading.value = true;
      var res = await repository.get(url: repository.urlApi + repository.allrestaurant);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        restaurants.value = data.map((json) => AllRestaurantModel.fromJson(json)).toList();
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to load restaurants: $e');
    }
  }
 
}
