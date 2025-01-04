// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/product_model.dart';

class ProductState extends GetxController {
  var isLoading = true;
  Repository repository = Repository();
  List<ProductModel> selectproductFoodList = [];
  List<ProductModel> getmenufoodlist = [];
  List<ProductModel> selectproductdrinkList = [];
  List<ProductModel> getmenudrinklist = [];
  List<ProductModel> getmenulist = [];
  List<MenuNote> productNote = [];

  @override
  Future<void> getmenu(String resID) async {
    try {
      isLoading=true;
      var res = await repository.get(url: repository.urlApi + repository.getRestaurantmenu + resID);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        getmenulist = data.map((json) => ProductModel.fromJson(json)).toList();
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
        isLoading = false;
      }
      update();
    } catch (e) {
      isLoading = false;
      print('Failed to menu: $e');
      update();
    }
  }


  Future<void> getProductdetai(String resID) async {
    try {
      isLoading=true;
      var res = await repository.get(url: repository.urlApi + repository.getMenuNote + resID);
      if (res.statusCode == 200) {
          var responseBody = jsonDecode(res.body);
        var data = jsonDecode(res.body) as List;
        productNote = data.map((json) => MenuNote.fromJson(json)).toList();
        isLoading = false;
      }
      update();
    } catch (e) {
      isLoading = false;
      print('Failed to menu: $e');
      update();
    }
  }


}
