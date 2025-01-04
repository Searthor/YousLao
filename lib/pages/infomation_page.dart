import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/image_upload_model.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/auth_controller.dart';
import 'package:yous_app/states/pickImage_state.dart';
import 'package:yous_app/states/profile_state.dart';
import 'package:yous_app/util/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yous_app/util/profile_edit_loading.dart';
import 'package:yous_app/util/profile_loading.dart';
import 'dart:io';

import 'package:yous_app/widgets/custom_dialog.dart';

class InfomationPage extends StatefulWidget {
  const InfomationPage({super.key});

  @override
  State<InfomationPage> createState() => _InfomationPageState();
}

class _InfomationPageState extends State<InfomationPage> {
  ProfileState profileState = Get.put(ProfileState());
  final TextEditingController phoneC = TextEditingController();
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController comfirmPasswordC = TextEditingController();
  String userimage = '';
  PickImageState pickImageState = Get.put(PickImageState());

  @override
  void initState() {
    _fetchHistory();
    super.initState();
  }

  Future<void> _fetchHistory() async {
    setState(() {
      profileState.isLoading = true;
    });
    await profileState.getProfile();
    await pickImageState.deleteFileImage();
    phoneC.text = profileState.profileModel?.phone ?? '';
    usernameC.text = profileState.profileModel?.fullname ?? '';
    userimage = profileState.profileModel?.image ?? '';
    setState(() {
      profileState.isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    await profileState.getProfile();
    await pickImageState.deleteFileImage();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    AppColors appColors = AppColors();
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text('personal_information'.tr,
            style: TextStyle(color: appColors.backgroundColor)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: appColors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: appColors.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: GetBuilder<ProfileState>(
          builder: (get) {
            if (get.isLoading) {
              return ProfileEditLoading();
            }
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // -- IMAGE with ICON
                          Stack(
                            children: [
                              GetBuilder<PickImageState>(builder: (get) {
                                if (get.file != null) {
                                  return SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          File(get.file!.path),
                                          fit: BoxFit.cover,
                                        )),
                                  );
                                }
                                return SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      Repository().urlApi + userimage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 120,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // Default image to show when the network image fails
                                        return Image.asset(
                                          'assets/images/user.png', // Path to your default image
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 120,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    pickImageState.showPickImage(context);
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: appColors.mainColor,
                                    ),
                                    child: const Icon(Icons.camera,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          buildTextInput(
                            labelText: "phone".tr,
                            prefixIcon: const Icon(Icons.phone),
                            hintText: "20 xxx xxx xx",
                            controller: phoneC,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          buildTextInput(
                            labelText: 'fullname'.tr,
                            prefixIcon: const Icon(Icons.person),
                            hintText: "fullname".tr,
                            controller: usernameC,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          buildTextInput(
                            labelText: "password".tr,
                            prefixIcon: const Icon(Icons.key),
                            hintText: "password".tr,
                            controller: passwordC,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          buildTextInput(
                            labelText: "confirm_password".tr,
                            prefixIcon: const Icon(Icons.key),
                            hintText: "confirm_password".tr,
                            controller: comfirmPasswordC,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          // -- Form Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (usernameC.text.trim().isEmpty) {
                                  CustomDialog().dialogShowMessage(
                                    context,
                                    message: 'please_enter_the_complete_information'.tr,
                                  );
                                } else {
                                  profileState.updateProfile(
                                      username: usernameC.text,
                                      password: passwordC.text,
                                      comfirmPassword: comfirmPasswordC.text,
                                      imageUploadModel:
                                          pickImageState.file != null
                                              ? ImageUploadModel(
                                                  fieldName: 'image',
                                                  xFile: pickImageState.file!)
                                              : null);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appColors.mainColor,
                                side: BorderSide.none,
                                shape: const StadiumBorder(),
                              ),
                              child: Text("edit".tr,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // -- Created Date and Delete Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                              ElevatedButton(
                                onPressed: () {
                                  // Implement the delete functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.1),
                                  elevation: 0,
                                  foregroundColor: Colors.red,
                                  shape: const StadiumBorder(),
                                  side: BorderSide.none,
                                ),
                                child:  Text('delete_account'.tr),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextInput({
    required String labelText,
    required Icon prefixIcon,
    required String hintText,
    required bool obscureText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    AppColors appColors = AppColors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: const TextStyle(
            color: Color.fromARGB(255, 98, 98, 98),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50.0,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
