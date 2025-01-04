// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:yous_app/models/AllRestaurant_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/test.dart';

class RestaurantState extends GetxController {
  List<AllRestaurantModel> restaurants = [];
  var isLoading = true;

  Repository repository = Repository();

  @override
  void onInit() {
    fetchRestaurants();
    super.onInit();
  }

  Future<void> fetchRestaurants() async {
    try {
       isLoading = true;
      var res = await repository.get(url: repository.urlApi + repository.allrestaurant);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        restaurants = data.map((json) => AllRestaurantModel.fromJson(json)).toList();
        isLoading = false;
      }
      update();
    } catch (e) {
      isLoading = false;
      print('Failed to load restaurants: $e');
      update();
    }
  }
 
}
