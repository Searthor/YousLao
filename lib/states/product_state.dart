// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/product_model.dart';

class ProductState extends GetxController {
  var isLoading = true.obs;
  Repository repository = Repository();
  var selectproductFoodList = <ProductModel>[].obs;
  var getmenufoodlist = <ProductModel>[].obs;
  var selectproductdrinkList = <ProductModel>[].obs;
  var getmenudrinklist = <ProductModel>[].obs;
  var getmenulist = <ProductModel>[].obs;

  @override
  Future<void> getmenu(String resID) async {
    try {
      isLoading.value=true;
      var res = await repository.get(url: repository.urlApi + repository.getRestaurantmenu + resID);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        getmenulist.value = data.map((json) => ProductModel.fromJson(json)).toList();
        selectproductFoodList.clear();
        selectproductdrinkList.clear();
        getmenufoodlist.clear();
        getmenudrinklist.clear();
        for (var element in jsonDecode(res.body)){
          if (element['type'] == 1) {
            selectproductFoodList.add(ProductModel.fromJson(element)); 
            getmenufoodlist = selectproductFoodList;
          } 
          else if (element['type'] == 2) {
            selectproductdrinkList.add(ProductModel.fromJson(element)); 
            getmenudrinklist = selectproductdrinkList;
          } 
        }
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to menu: $e');
    }
  }
}
