// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/product_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/table_mode.dart';
import 'package:yous_app/states/table_state.dart';

class ScannerState extends GetxController {
  List<TableModel> gettabeData =[];
  List<TableProductModel> gettabeOrderData = [];
  var isLoading = true;
  var checkTable = true;
  var Orderbyme = true;
  Repository repository = Repository();

  Future<void> gettablebyqr(String ID) async {
    try {
      checkTable= true;
      isLoading= true;
      Orderbyme= true;
      var res = await repository.get(
          url: repository.urlApi + repository.Scannertable + ID, auth: true);
      if (res.statusCode == 200) {
       print(ID);
       print(res.body);
        var data = jsonDecode(res.body) as List;
        gettabeData =data.map((json) => TableModel.fromJson(json)).toList();
        if (gettabeData[0].status == 2) {
          Orderbyme= false;
          gettableOder(gettabeData[0].id.toString());
        }else{
          Orderbyme= false;
          gettabeOrderData =[];
        }
        isLoading = false;
      } else if (res.statusCode == 500) {
        checkTable = false;
        isLoading = false;
      } else {
         Orderbyme= false;
        isLoading = false;
      }
      update();
    } catch (e) {
      isLoading = false;
      print('Failed to fetch data: $e');
      update();
    }
  }

  Future<void> gettableOder(String ID) async {
    try {
      var res = await repository.get(
          url: repository.urlApi + repository.getTableOrder + ID, auth: true);
      if (res.statusCode == 200) {
        var responseBody = jsonDecode(res.body);
        var data = jsonDecode(res.body) as List;
        gettabeOrderData =
            data.map((json) => TableProductModel.fromJson(json)).toList();
        checkTable = false;
      }
      update();
    } catch (e) {
      isLoading = false;
      print('Failed to fetch data: $e');
    }
  }

  // Method to reset tableModel data
  void resetTableData() {
    gettabeData = [];
  }
}
