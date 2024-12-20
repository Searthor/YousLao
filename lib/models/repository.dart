import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:yous_app/models/image_upload_model.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:yous_app/widgets/custom_dialog.dart';
export 'dart:convert';
class Repository {
  String urlApi = 'http://192.168.1.36:8000/';
  // String urlApi = 'https://demo.youhotel.la/';
  String allrestaurant = 'api/Restaurants';
  String getRestaurantDetail = 'api/getRestaurantdetail/';
  String getRestaurantmenu = 'api/Restaurants_menu_list/';
  String Scannertable = 'api/Scannertable/';
  String getTableOrder = 'api/getTableOrder/';
  String createOrder = 'api/customer_create_order';
  String register = 'api/customer_register';
  String login = 'api/customer_login';
  String getprofile = 'api/customer_getprofile';
  String logout = 'api/customer_logout';
  String slide = 'api/slide';
  String gethistorys = 'api/historys';
  String gethistorysid = 'api/historys/';
  String updateProfile = 'api/updateProfile';
  AppVerification appVerification = Get.put(AppVerification());
  AppColors appColors = AppColors();

  Future<http.Response> get(
      {required String url, Map<String, String>? header, bool? auth}) async {
    try {
      var res = await http
          .get(Uri.parse(url),
              headers: header ??
                  {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    if (auth ?? false)
                      'Authorization': 'Bearer ${appVerification.token}'
                  })
          .timeout(const Duration(seconds: 30), onTimeout: () {
        return http.Response("Error", 408);
      });
      if (res.statusCode == 401 || res.statusCode == 408) {
        appVerification.removeToken();
        Get.offAll(() => LoginPage());
        return res;
      } else if (res.statusCode == 408) {
        appVerification.removeToken();
        Get.offAll(() => LoginPage());
        CustomDialog().showToast(
            backgroundColor: appColors.mainColor,
            text: 'Connect Internet Error');
        return res;
      }
      return res;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.Response> post(
      {required String url,
      Map<String, String>? header,
      Map<String, dynamic>? body,
      bool? auth}) async {
    try {
      var res = await http
          .post(Uri.parse(url),
              body: jsonEncode(body), // Ensure the body is JSON-encoded
              headers: header ??
                  {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    if (auth ?? false)
                      'Authorization': 'Bearer ${appVerification.token}'
                  })
          .timeout(const Duration(seconds: 15), onTimeout: () {
        return http.Response("Error", 408);
      });
      if (res.statusCode == 401) {
        // appVerification.storage.erase();
       Get.offAll(() => LoginPage());
        return res;
      }
      return res;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }


    Future<http.Response> postMultiPart(
      {required String url,
      Map<String, String>? header,
      bool? auth,
      Map<String, String>? body,
      required List<ImageUploadModel> listFile}) async {
    var headers = header ??
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (auth ?? false) 'Authorization': 'Bearer ${appVerification.token}'
        };
    try {
      var res = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      res.headers.addAll(headers);
      if (body != null) {
        res.fields.addAll(body);
      }
      for (var element in listFile) {
        res.files.add(
            await _addImage(fieldName: element.fieldName, file: element.xFile));
      }

      var response = await res.send();
      var result = await http.Response.fromStream(response);
      return result;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.MultipartFile> _addImage(
      {XFile? file, required String fieldName}) async {
    Uint8List data = await file!.readAsBytes();
    List<int> list = data.cast();
    var picture = http.MultipartFile.fromBytes(fieldName, list,
        filename: path.basename(file.path));
    return picture;
  }
}
