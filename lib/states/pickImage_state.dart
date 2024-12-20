
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:yous_app/states/app_colors.dart';

class PickImageState extends GetxController {
  final ImagePicker _picker = ImagePicker();
  AppColors appColor = AppColors();
  XFile? file;

  String? imageProfile;

  pickImage(ImageSource imageSource) async {
    var image = await _picker.pickImage(source: imageSource);
    if (image == null) {
      return;
    }
    file = image;

    update();
  }
  deleteFileImage() {
    file = null;
    update();
  }

  void deleteImageProfile() {
    imageProfile = null;
    update();
  }

  showPickImage(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          double fixSize = size.width + size.height;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Get.back();
                  pickImage(ImageSource.camera);
                },
                leading: Icon(
                  Icons.photo_camera,
                  color: appColor.mainColor,
                  size: fixSize * 0.0185,
                ),
                title: Text('Camera')
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  pickImage(ImageSource.gallery);
                },
                leading: Icon(
                  Icons.photo,
                  color: appColor.mainColor,
                  size: fixSize * 0.0185,
                ),
                title: Text("Gallery")
              )
            ],
          );
        });
  }
}
