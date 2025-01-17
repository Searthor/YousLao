import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/cart_page.dart';
import 'package:yous_app/pages/home_page.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/pages/profile_page.dart';
import 'package:yous_app/states/app_verification.dart';
import 'dart:convert';
import 'package:yous_app/widgets/custom_dialog.dart'; // Import to use jsonEncode
class AuthController extends GetxController {
  var isLoggedIn = false;
  Repository repository = Repository();
  AppVerification appVerification = Get.put(AppVerification());
  Future<void> register(
      {required String phone,
      String? name,
      required String password,
      required String comfirmPassword}) async {
    // print('object');
    try {
      var res = await repository.post(
        url: '${repository.urlApi}${repository.register}',
        body: {
          'phone': phone,
          'password': password,
          'name': name ?? '',
          'comfirmPassword': comfirmPassword,
        },
      );
      if (res.statusCode == 200) {
        CustomDialog().showToast(
            text: 'register_success'.tr,
            color: Colors.white,
            backgroundColor: Colors.green);
        Get.offAll(() => LoginPage());
      } else if (res.statusCode == 400) {
        CustomDialog().showToast(
            text: 'phone_is_regiseted'.tr,
            color: Colors.white,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login({
    required String phone,
    required String password,
    String? checkorder,
  }) async {
    try {
      var res = await repository.post(
        url: '${repository.urlApi}${repository.login}',
        body: {
          'phone': phone,
          'password': password,
        },
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['user'].toString() == "null") {
          Get.back();
          return CustomDialog().showToast(text: 'something_went_wrong');
        } else {
          await appVerification.setNewToken(
            text: jsonDecode(res.body)['token'],
          );
           appVerification.setInitToken();
           isLoggedIn = true; // Update the state here
         
         
          CustomDialog()
              .showToast(text: 'login_success'.tr, color: Colors.white);
          if (checkorder == 'order') {
            Get.back();
          } else {
            Get.to(
              () => HomePage(),
              // transition: Transition.rightToLeft,
            );
          }
          update();
        }
      } else {
        var jsonResponse = jsonDecode(res.body);
        CustomDialog().showToast(
            text: jsonResponse['message'],
            color: Colors.white,
            backgroundColor: Colors.red);
        update();
      }
    } catch (e) {
      print(e);
      update();
    }
  }

  logout() async {
    try {
      CustomDialog().dialogLoading();
      var data = {};
      var body = jsonEncode(data);
      var res = await repository.post(
          url: repository.urlApi + repository.logout, auth: true, body: {});
      if (res.statusCode == 200) {
        repository.appVerification.removeToken();
        CustomDialog().showToast(
            text: 'logout_success'.tr,
            color: Colors.white,
            backgroundColor: Colors.green);
         Get.to(
              () => HomePage(),
              transition: Transition.rightToLeft,
            );
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialog().showToast(text: 'something_wrong'.tr);
    }
  }
}
