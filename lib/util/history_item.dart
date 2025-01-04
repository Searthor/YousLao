import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/history_model.dart';
import 'package:intl/intl.dart';
import 'package:yous_app/pages/history_detail_page.dart';
import 'package:yous_app/routes.dart';

class HistoryItem extends StatelessWidget {
  final HistoryModel item;

  const HistoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###'); // Initialize the formatter
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryDetailPage(id: item.id)));
          // Get.toNamed(Routes.historyDetail,arguments: HistoryDetailPage(id: item.id));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('shop'.tr+':', item.shop, formatter),
            _buildRow('amount'.tr+':','${item.count}'+'list'.tr, formatter),
            _buildRow('total'.tr+':', '${formatter.format(item.total_price)} LAK', formatter),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.date, style: TextStyle(color: Colors.grey[700])),
                _buildStatus(item.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build rows with labels and values
  Widget _buildRow(String label, dynamic value, NumberFormat formatter) {
    // Format total_price if the value is a number
    String displayValue = value is int || value is double
        ? formatter.format(value) // Format the number
        : value.toString(); // Otherwise, use as is

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          displayValue,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  /// Widget to display status with color coding
  Widget _buildStatus(int status) {
    Color bgColor;
    String text;

    switch (status) {
      case 1:
        bgColor = Colors.blueAccent;
        text = 'new'.tr;
        break;
      case 2:
        bgColor = Colors.green;
        text = 'completed'.tr;
        break;
      default:
        bgColor = Colors.red;
        text = 'canceled'.tr;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
