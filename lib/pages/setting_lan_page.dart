import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/util/constants.dart';

class SettingLanPage extends StatefulWidget {
  const SettingLanPage({super.key});

  @override
  State<SettingLanPage> createState() => _SettingLanPageState();
}

class _SettingLanPageState extends State<SettingLanPage> {
  @override
  Widget build(BuildContext context) {
    bool isLao = Get.locale?.languageCode == 'la';

    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text(
          'setting_lan'.tr,
          style: TextStyle(
            color: appColors.backgroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: appColors.backgroundColor,
        ),
        child: Column(
          children: [
            _languageOption(
              isActive: isLao,
              onTap: () => Get.updateLocale(Locale('la', 'LA')),
              flagPath: 'assets/flags/laos.png',
              languageName: 'lao'.tr,
            ),
            Divider(color: appColors.grey1, thickness: 1),
            _languageOption(
              isActive: !isLao,
              onTap: () => Get.updateLocale(Locale('en', 'US')),
              flagPath: 'assets/flags/uk.png',
              languageName: 'english'.tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageOption({
    required bool isActive,
    required VoidCallback onTap,
    required String flagPath,
    required String languageName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    flagPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.flag, color: appColors.grey1);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  languageName,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: appColors.grey1,
                  ),
                ),
              ],
            ),
            if (isActive)
              Icon(Icons.check, color: appColors.grey1),
          ],
        ),
      ),
    );
  }
}
