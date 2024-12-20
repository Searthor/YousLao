// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:yous_app/models/history_model.dart';
import 'package:yous_app/models/repository.dart';

class HistoryState extends GetxController {
  var isLoading = true;
  List<HistoryModel> historydata = [];
  List<HistoryDetailModel> historyDetaildata = [];
  Repository repository = Repository();

  Future<void> getHistorys() async {
    try {
      isLoading = true;
      var res = await repository.get(
          url: repository.urlApi + repository.gethistorys, auth: true);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        historydata = data.map((json) => HistoryModel.fromJson(json)).toList();
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      print('Failed to load restaurants: $e');
    }
  }

  getHistorysByid(String ID) async {
    try {
      isLoading = true;
      var res = await repository.get(
          url: repository.urlApi + repository.gethistorysid + ID, auth: true);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        historyDetaildata =
            data.map((json) => HistoryDetailModel.fromJson(json)).toList();
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    update();
  }
}
