import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog {
  AppColors appColors = AppColors();

  Future<bool> yesAndNoDialogWithText(BuildContext context, String? text,
      {double? fontSize,
      String? cancelText,
      String? confirmText,
      IconData? iconData,
      Color? color}) async {
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set the border radius here
        ),
        backgroundColor: appColors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Icon(
                Icons.question_mark_sharp,
                size: 50,
                color: appColors.mainColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              (text ?? "").tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color ?? appColors.mainColor,
                fontSize: fontSize ?? 20,
              ),
            )),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => const Color.fromARGB(255, 255, 0, 0),
                  ),
                  shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set your desired border radius here
                    ),
                  ),
                ),
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text(
                  cancelText ?? "ຍົກເລີກ".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => appColors.mainColor),
                  shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Set your desired border radius here
                    ),
                  ),
                ),
                onPressed: () {
                  Get.back(result: true);
                },
                child: Text(
                  confirmText ?? "ຢືນຢັນ".tr,
                  style: TextStyle(
                    color: appColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  dialogLoading() async {
    await Get.dialog(
      Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        double fixSize = size.width + size.height;
        return SizedBox(
          height: fixSize * 0.04,
          width: fixSize * 0.04,
          child: Center(
            child: CircularProgressIndicator(
              color: appColors.mainColor,
            ),
          ),
        );
      }),
      barrierDismissible: false,
    );
  }

  void dialogShowMessage(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'ແຈ້ງເຕືອນ',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ປິດ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  showToast({
    String? text,
    Color? color,
    double? fontSize,
    Color? backgroundColor,
    ToastGravity? gravity,
  }) async {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: (text ?? "").tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            backgroundColor?.withOpacity(0.75) ?? Colors.green,
        textColor: color?.withOpacity(1) ?? Colors.white,
        fontSize: fontSize ?? 16.0);
  }
}
