import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/history_detail_page.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:get/get.dart';
import 'package:yous_app/states/scanner_state.dart';
import 'package:yous_app/widgets/custom_dialog.dart';

class TableState extends GetxController {
  AppVerification appVerification = Get.put(AppVerification());
  Repository repository = Repository();
  ScannerState scannerState = Get.put(ScannerState());
  String orderID = "";
  bool isLoading = true;

  Future<void> checkTableStatus(String id, BuildContext context) async {
    try {
      isLoading = true;
      update();
      var res = await repository.get(
          url: repository.urlApi + repository.Checkorder + id, auth: true);

      if (res.statusCode == 200) {
        var responseBody = jsonDecode(res.body);
        String status = responseBody['status'];
        int Table_id = responseBody['tableID'];
        int fetchedOrderID = responseBody['orderID'];
        if (status == 'success') {
          orderID = '';
          scannerState.gettablebyqr(Table_id.toString());
          update();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryDetailPage(id: fetchedOrderID),
            ),
          );
          CustomDialog().showToast(
              text: 'Check bill Successfuly!',
              color: Colors.white,
              backgroundColor: Colors.green);
        }

      } else {
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
    } finally {
      isLoading = false;
      update(); // Notify listeners that loading is done
    }
  }
}
