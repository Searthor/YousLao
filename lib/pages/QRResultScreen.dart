import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yous_app/pages/order_page.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/cart_controller.dart';
import 'package:yous_app/states/scanner_state.dart';
class QRResultScreen extends StatelessWidget {
  final String code;
  final VoidCallback resetScan;

  QRResultScreen({required this.code, required this.resetScan});

  final ScannerState scannerState = Get.put(ScannerState());
  final AppColors appColors = AppColors();
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    // Clear the cart and fetch table data
    cartController.clearCart();
    scannerState.gettablebyqr(code);

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
            Get.back(); // Use GetX for navigation
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Center(
          child: GetBuilder<ScannerState>(
            builder: (scanner) {
              if (scanner.isLoading) {
                return CircularProgressIndicator();
              } else if (scanner.Orderbyme) {
                return _buildMessage(
                  'this_table_has_already_been_reserved'.tr,
                  appColors.mainColor,
                  resetScan,
                );
              } else if (scanner.gettabeData.isEmpty) {
                return _buildMessage(
                  'the_QR_code_is_invalid'.tr,
                  appColors.mainColor,
                  resetScan,
                );
              } else {
                return _buildTableDetails(scanner.gettabeData);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(String message, Color buttonColor, VoidCallback resetScan) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            resetScan(); // Reset scan state
            Get.back(); // Use GetX for navigation
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
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
  }

  Widget _buildTableDetails(tableData) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tableData.length,
      itemBuilder: (context, index) {
        final table = tableData[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              Text('welcome_to'.tr, style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text(table.branch_name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('table'.tr + ' : ${table.name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('do_you_want_to_order_food'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("object");

                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderPage(tableID:table.id, branchId: table.branch_id)));
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
                  Get.back(); // Use GetX for navigation
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
}
