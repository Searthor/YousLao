// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/slide_model.dart';
import 'package:yous_app/models/table_mode.dart';

class SlideController extends GetxController {
  var slidedata = <SlideModel>[].obs;
  var isLoading = true.obs;
  Repository repository = Repository();
  Future<void> getSlides() async {
    try {
      isLoading.value = true;
      var res = await repository.get(
        url: '${repository.urlApi}${repository.slide}',
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        slidedata.value =
            data.map((json) => SlideModel.fromJson(json)).toList();
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
}
