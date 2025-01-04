// states/restaurant_states.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/models/slide_model.dart';
import 'package:yous_app/models/table_mode.dart';

class SlideController extends GetxController {
  List<SlideModel> slidedata = [];
  var isLoading = true;
  Repository repository = Repository();
  Future<void> getSlides() async {
    try {
      isLoading = true;
      var res = await repository.get(
        url: '${repository.urlApi}${repository.slide}',
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        slidedata =
            data.map((json) => SlideModel.fromJson(json)).toList();
        isLoading = false;
        update();
      } else {
        print('No data found.');
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      print('Failed to fetch data: $e');
      update();
    }
  }
}
