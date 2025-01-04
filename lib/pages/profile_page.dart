import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/pages/history_page.dart';
import 'package:yous_app/pages/home_page.dart';
import 'package:yous_app/pages/infomation_page.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/pages/qrscanner.dart';
import 'package:yous_app/pages/register_page.dart';
import 'package:yous_app/pages/restaurant_detail.dart';
import 'package:yous_app/pages/setting_lan_page.dart';
import 'package:yous_app/routes.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/auth_controller.dart';
import 'package:yous_app/states/profile_state.dart';
import 'package:yous_app/util/buildNavItem.dart';
import 'package:yous_app/util/profile_loading.dart';
import 'package:yous_app/util/profile_memu_item.dart';
import 'package:yous_app/widgets/custom_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  AppColors appColors = AppColors();
  TextEditingController fullname = TextEditingController();
  ProfileState profileState = Get.put(ProfileState());
  AuthController authController = Get.put(AuthController());
  void initState() {
    profileState.checkToken();
    setData();
    super.initState();
  }

  setData() {
    if (profileState.profileModel != null) {
      fullname.text = profileState.profileModel?.fullname.toString() ?? '';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainColor,
      floatingActionButton: Container(
        height: 56.0,
        width: 56.0,
        decoration: BoxDecoration(
          color: appColors.mainColor,
          border: Border.all(width: 3, color: appColors.backgroundColor),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Qrscanner()),
            );
          },
          backgroundColor: Color.fromARGB(0, 235, 17, 17),
          elevation: 0,
          child: Icon(
            Icons.qr_code_scanner,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: appColors.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                BuildNavItem(
                  icon: Icons.home,
                  label: 'home'.tr,
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()))
                  },
                ),
                BuildNavItem(icon: Icons.reviews, label: 'review'.tr),
              ],
            ),
            Row(
              children: [
                BuildNavItem(icon: Icons.person, label: 'me'.tr),
                BuildNavItem(icon: Icons.help, label: 'report'.tr),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: appColors.backgroundColor,
        height: double.infinity,
        child: SingleChildScrollView(
          child: GetBuilder<ProfileState>(
            builder: (getProfile) {
              if (profileState.check == false) {
                return ProfileLoading();
              } else {
                return Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Column(children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: getProfile.profileModel?.image != null
                                    ? Image.network(
                                        Repository().urlApi +
                                            getProfile.profileModel!.image!,
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
                                      )
                                    : Image.asset('assets/images/user.png')),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            profileState.profileModel?.fullname.toString() ??
                                'not_logged_in_yet'.tr,
                            style: TextStyle(
                              fontSize: 20,
                              color: appColors.black2,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      profileState.profileModel == null ||
                              profileState.profileModel == ' '
                          ? Column(
                              children: [
                                ProfileMenuItem(
                                  icon: Icon(
                                    Icons.login,
                                    color: appColors.grey1,
                                  ),
                                  text: 'login'.tr,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ProfileMenuItem(
                                  icon: Icon(
                                    Icons.person_add,
                                    color: appColors.grey1,
                                  ),
                                  text: 'register'.tr,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterPage()),
                                    );
                                  },
                                ),
                              ],
                            )
                          : SizedBox(height: 5),
                      Divider(),
                      ProfileMenuItem(
                        icon: Icon(Icons.settings, color: appColors.grey1),
                        text: 'setting_lan'.tr,
                        next_plan: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingLanPage()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      profileState.profileModel != null
                          ? Column(
                              children: [
                                SizedBox(height: 20),
                                ProfileMenuItem(
                                  icon: Icon(
                                    Icons.history,
                                    color: appColors.grey1,
                                  ),
                                  text: 'transaction_history'.tr,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HistoryPage()),
                                    );
                                  },
                                  next_plan: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ProfileMenuItem(
                                  icon: Icon(
                                    Icons.person,
                                    color: appColors.grey1,
                                  ),
                                  text: 'personal_information'.tr,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfomationPage()),
                                    );
                                  },
                                  next_plan: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var res = await CustomDialog()
                                        .yesAndNoDialogWithText(
                                      context,
                                      'do_you_want_to_logout?'.tr,
                                      iconData: Icons.exit_to_app,
                                    );
                                    if (res == true) {
                                      authController.logout();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: appColors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                child: Icon(
                                                  Icons.logout_outlined,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'logout'.tr,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox()
                    ]),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
