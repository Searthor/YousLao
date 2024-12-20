// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/table_mode.dart';
import 'package:yous_app/models/product_model.dart';
import 'package:yous_app/pages/test.dart';

class OrderState extends GetxController {
  var gettabeData = <TableModel>[].obs;
  var isLoading = true.obs;
  Repository repository = Repository();
  var selectproductFoodList = <ProductModel>[].obs;
  var getmenufoodlist = <ProductModel>[].obs;
  var selectproductdrinkList = <ProductModel>[].obs;
  var getmenudrinklist = <ProductModel>[].obs;
  var getmenulist = <ProductModel>[].obs;

  @override
  Future<void> gettablebyqr(String ID) async {
    try {
      gettabeData.value=[];
      var res = await repository.get(url: repository.urlApi + repository.Scannertable + ID);
      if (res.statusCode == 200) {
    
        var data = jsonDecode(res.body) as List;
        gettabeData.value = data.map((json) => TableModel.fromJson(json)).toList();
        isLoading.value = false;
      }else{
        print('NO data');
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to url: $e');
    }
  }


  Future<void> getmenu(String resID) async {
    try {
      var res = await repository.get(url: repository.urlApi + repository.getRestaurantmenu + resID);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        getmenulist.value = data.map((json) => ProductModel.fromJson(json)).toList();
        isLoading.value = false;
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
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to menu: $e');
    }
  }
}
