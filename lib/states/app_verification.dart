import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppVerification extends GetxController {
  GetStorage storage = GetStorage();
  var token = '';
  setInitToken() {
    try {
      token = storage.read('token') ?? "";
    } catch (e) {
      print("Error reading token or userID: $e");
    }
    update();
  }
  Future<void> setNewToken({required String text}) async {
    // Save the token as a String
    await storage.write('token', text);
    // Read the token value back
    token = storage.read('token') ?? "";
    update();
  }

  removeToken() async {
    await storage.write('token', "");
    token = "";
    update();
  }
}
