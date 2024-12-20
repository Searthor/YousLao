import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppVerification extends GetxController {
  GetStorage storage = GetStorage();
  var userID = ''.obs;
  var token = ''.obs;
  setInitToken() {
    try {
      token.value = storage.read('token') ?? "";
      userID.value = storage.read('userID') ?? "";
    } catch (e) {
      print("Error reading token or userID: $e");
    }
  }

  Future<void> setNewToken({required String text}) async {
    // Save the token as a String
    await storage.write('token', text);

    // Convert userID to String before saving
    await storage.write('userID', "asdadadasd");

    // Read the token value back
    token.value = storage.read('token') ?? "";
  }

  removeToken() async {
    await storage.write('token', "");
    await storage.write('userID', "");
    token.value = "";
    userID.value = "";
    update();
  }
}
