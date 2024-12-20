// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:yous_app/models/AllRestaurant_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/test.dart';

class RestaurantDetailState extends GetxController {
  var getRestaurantlist = <getRestaurant>[].obs;
  var getmenulist = <getRestaurantmenu>[].obs;
  var selectproductFoodList = <getRestaurantmenu>[].obs;
  var getmenufoodlist = <getRestaurantmenu>[].obs;
  var selectproductdrinkList = <getRestaurantmenu>[].obs;
  var getmenudrinklist = <getRestaurantmenu>[].obs;
  var isLoading = true.obs;

  Repository repository = Repository();


  Future<void> getRestaurantdetail(String resID) async {
    try {
      isLoading.value = true;
      var res = await repository.get(url: repository.urlApi + repository.getRestaurantDetail + resID);
      if (res.statusCode == 200) {
        // print(res.body);
        var data = jsonDecode(res.body) as List;
        getRestaurantlist.value = data.map((json) => getRestaurant.fromJson(json)).toList();
        getmenu(resID);
        // isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to load restaurants: $e');
    }
  }
  Future<void> getmenu(String resID) async {
    try {
      var res = await repository.get(url: repository.urlApi + repository.getRestaurantmenu + resID);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        getmenulist.value = data.map((json) => getRestaurantmenu.fromJson(json)).toList();
        // isLoading.value = false;
        selectproductFoodList.clear();
        selectproductdrinkList.clear();
        getmenufoodlist.clear();
        getmenudrinklist.clear();
        for (var element in jsonDecode(res.body)){
          if (element['type'] == 1) {
            print('food');
            selectproductFoodList.add(getRestaurantmenu.fromJson(element)); 
            getmenufoodlist = selectproductFoodList;
          } 
          else if (element['type'] == 2) {
            selectproductdrinkList.add(getRestaurantmenu.fromJson(element)); 
            getmenudrinklist = selectproductdrinkList;
          } 
        }
      }
       isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Failed to menu: $e');
    }
  }
}
