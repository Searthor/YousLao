import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/table_mode.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:get/get.dart';

class ProfileState extends GetxController {
  AppVerification appVerification = Get.put(AppVerification());
  Repository repository = Repository();
    var gettabeData = <TableModel>[].obs;
  Future<void> gettablebyqr(String ID) async {
    try {
      var res = await repository.get(url: '${repository.urlApi}${repository.Scannertable}$ID');
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        gettabeData.value = data.map((json) => TableModel.fromJson(json)).toList();
      } else {
        print('No data found.');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }
  
}
