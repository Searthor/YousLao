import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:yous_app/pages/order_page.dart';
import 'package:yous_app/states/app_colors.dart';
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

class QRResultScreen extends StatelessWidget {
  final String code;
  final VoidCallback resetScan;
  final ScannerState scannerState = Get.put(ScannerState());
  AppColors appColors = AppColors();
  CartController cartController = Get.put(CartController());
  QRResultScreen({required this.code, required this.resetScan}) {
    cartController.clearCart();
    scannerState.gettablebyqr(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        title: Text(
          "Scan Result",
          style: TextStyle(color: appColors.backgroundColor),
        ),
        centerTitle: true,
        backgroundColor: appColors.mainColor,
        leading: IconButton(
          onPressed: () {
            resetScan(); // Reset scan state
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
      
        decoration: BoxDecoration(
            color:appColors.backgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (scannerState.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (scannerState.checkTable.value == false) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'this_table_has_already_been_reserved'.tr,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          resetScan(); // Reset scan state
                          Navigator.pop(context); // Return to scanner
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          "rescan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (scannerState.gettabeData.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text('the_QR_code_is_invalid'.tr)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        resetScan(); // Reset scan state
                        Navigator.pop(context); // Return to scanner
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
                  ],
                );
              } else {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: scannerState.gettabeData.length,
                  itemBuilder: (context, index) {
                    final Tabledata = scannerState.gettabeData[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        children: [
                          Text('welcome_to'.tr, style: TextStyle(fontSize: 20)),
                          SizedBox(height: 20),
                          Text(Tabledata.branch_name,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('table'.tr+' : ${Tabledata.name}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('do_you_want_to_order_food'.tr,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderPage(
                                    tableID: Tabledata.id,
                                    branchId: Tabledata.branch_id,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Text(
                              "choose_food".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              resetScan(); // Reset scan state
                              Navigator.pop(context); // Return to scanner
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Text(
                              "rescan".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
