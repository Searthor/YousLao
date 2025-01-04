import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:yous_app/pages/QRResultScreen.dart';
import 'package:yous_app/pages/home_page.dart';
import 'package:yous_app/pages/order_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/app_verification.dart';
import 'package:yous_app/states/cart_controller.dart';
import 'package:yous_app/states/scanner_state.dart';

class Qrscanner extends StatefulWidget {
  @override
  State<Qrscanner> createState() => _QrscannerState();
}

class _QrscannerState extends State<Qrscanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanCompleted = false;
  AppColors appColors = AppColors();
  AppVerification appVerification = Get.put(AppVerification());

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void resetScan() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  void initState() {
    super.initState();
    appVerification.setInitToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text("scan_qrcode".tr,style: TextStyle(color: appColors.backgroundColor),),
        centerTitle: true,
         leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          if (!isScanCompleted)
            Stack(
              children: [
                MobileScanner(
                  controller: cameraController,
                  onDetect: (barcodeCapture) {
                    if (!isScanCompleted) {
                      setState(() {
                        isScanCompleted = true;
                      });
                      String code =
                          barcodeCapture.barcodes.first.rawValue ?? "---";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRResultScreen(
                            code: code,
                            resetScan: resetScan, // Pass reset function
                          ),
                        ),
                      );
                    }
                  },
                ),
                QRScannerOverlay(
                  overlayColor: Colors.black26,
                  borderColor: appColors.mainColor,
                  borderRadius: 20,
                  borderStrokeWidth: 1,
                  scanAreaWidth: 250,
                  scanAreaHeight: 250,
                ),
              ],
            )
          else
            Center(
              child: ElevatedButton(
                onPressed: () {
                  resetScan(); // Reset scan state
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  "rescan".tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
