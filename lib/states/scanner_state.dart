// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/product_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/table_mode.dart';

class ScannerState extends GetxController {
  var gettabeData = <TableModel>[].obs;
  var gettabeOrderData = <TableProductModel>[].obs;
  var isLoading = true.obs;
  var checkTable = true.obs;
  Repository repository = Repository();

  Future<void> gettablebyqr(String ID) async {
    try {
      checkTable.value = true;
      isLoading.value = true;
      var res = await repository.get(
        url: '${repository.urlApi}${repository.Scannertable}$ID',
        auth: true
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        gettabeData.value =
            data.map((json) => TableModel.fromJson(json)).toList();
        if (gettabeData[0].status == 2) {
          gettableOder(gettabeData[0].id);
        }
        isLoading.value = false;
      } else if (res.statusCode == 500) {
        final data = jsonDecode(res.body);
        print("Response: ${data['message']}");
        print('---------------------------------------');
        print('No data found.');
        print('---------------------------------------');
        checkTable.value = false;
        isLoading.value = false;
      } else {
        print('No data found.');
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to fetch data: $e');
    }
  }

  Future<void> gettableOder(ID) async {
    try {
      var res = await repository.get(
          url: '${repository.urlApi}${repository.getTableOrder}$ID');
      if (res.statusCode == 200) {
        var responseBody = jsonDecode(res.body);
        var data = jsonDecode(res.body) as List;
        gettabeOrderData.value =
            data.map((json) => TableProductModel.fromJson(json)).toList();
      } else {
        print('-------------------------------------');
        print(res.statusCode);
        print('-------------------------------------');
      }
    } catch (e) {
      isLoading.value = false;
      print('Failed to fetch data: $e');
    }
  }

  // Method to reset tableModel data
  void resetTableData() {
    gettabeData.value = [];
  }
}
