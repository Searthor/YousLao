import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:yous_app/models/image_upload_model.dart';
import 'package:yous_app/models/profile_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:get/get.dart';
import 'package:yous_app/widgets/custom_dialog.dart';
class ProfileState extends GetxController {
  AppVerification appVerification = Get.put(AppVerification());
  Repository repository = Repository();
  bool check = true;
  bool isLoading = true;
  ProfileModel? profileModel;
  checkToken() {
    if (appVerification.token == '' || appVerification.token.isEmpty) {
      profileModel = null;
    } else {
      getProfile();
    }
  }
  Future<void> getProfile() async {
    try {
      check = false;
      isLoading = true;
      var res = await repository.get(
          url: repository.urlApi + repository.getprofile, auth: true);
      profileModel = null;
      if (res.statusCode == 200) {
        profileModel = ProfileModel.fromJson(jsonDecode(res.body)['data']);
      } else {
        throw res.body;
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      print(e.toString());
    }
    check = true;
    update();
  }

  updateProfile(
      {String? username,
      ImageUploadModel? imageUploadModel,
      required String? password,
      required String? comfirmPassword}) async {
    try {
      
      var res = await repository.postMultiPart(
          url: repository.urlApi + repository.updateProfile,
          body: {
            'password': password ?? '',
            'username': username ?? '',
            'comfirmPassword': comfirmPassword ?? '',
          },
          auth: true,
          listFile: imageUploadModel != null ? [imageUploadModel!] : []);

     

      if (res.statusCode == 200) {
        CustomDialog().showToast(
            text: 'ແກ້ໄຂຂໍ້ມູນສໍາເລັດ',
            color: Colors.white,
            backgroundColor: Colors.green);
      }
      getProfile();
      Get.back();
      update();

    } catch (e) {
      print(e);
      update();
    }
  }
}
