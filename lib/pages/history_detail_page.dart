import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/history_state.dart';

class HistoryDetailPage extends StatefulWidget {
  final int? id;
  const HistoryDetailPage({super.key, required this.id});

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final AppColors appColors = AppColors();
  final HistoryState historyState = Get.put(HistoryState());

  @override
  void initState() {
    historyState.getHistorysByid(widget.id.toString());
    super.initState();
  }

  Future<void> _refreshData() async {
    await historyState.getHistorysByid(widget.id.toString());
  }

  String formatPrice(dynamic price) {
    // Ensure price is treated as a double
    final double priceAsDouble = double.tryParse(price.toString()) ?? 0.0;
    final formatter =
        NumberFormat.decimalPattern(); // Format as plain number with commas
    return formatter.format(priceAsDouble);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text(
          'details'.tr,
          style: TextStyle(color: appColors.backgroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: GetBuilder<HistoryState>(
          builder: (get) {
            if (get.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: historyState.historyDetaildata.length,
                itemBuilder: (context, index) {
                  final item = historyState.historyDetaildata[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${item.shop}',
                          style: TextStyle(
                            color: appColors.mainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            color: item.status == 1
                                ? Colors.blueAccent
                                : item.status == 2
                                    ? Colors.green
                                    : Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            item.status == 1
                                ? 'new'.tr
                                : item.status == 2
                                    ? 'completed'.tr
                                    : 'canceled'.tr,
                            style: TextStyle(
                              color: appColors.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Transaction Details
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID : ${item.code}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'date'.tr+': ${item.date}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),

                      // Product Table
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            _buildTableRow(
                              "product".tr,
                              "price".tr,
                              "qty".tr,
                              "total_price".tr,
                              isHeader: true,
                            ),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: item.product.length,
                              itemBuilder: (context, index) {
                                final pd = item.product[index];
                                return _buildTableRow(
                                  pd.name,
                                  formatPrice(pd.productPrice),
                                  "x${pd.qty}",
                                  '${formatPrice(pd.total_price)} LAK',
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(),

                      // Summary Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryRow(
                              label: 'sub_total'.tr+':',
                              value: '${formatPrice(item.total)} LAK',
                            ),
                            _SummaryRow(
                                label: 'discount'.tr+':', value: formatPrice(0)),
                            const Divider(),
                            _SummaryRow(
                              label: 'total'.tr,
                              value: '${formatPrice(item.total)} LAK',
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTableRow(String col1, String col2, String col3, String col4,
      {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TableCell(text: col1, isHeader: isHeader),
          _TableCell(text: col2, isHeader: isHeader),
          _TableCell(text: col3, isHeader: isHeader),
          _TableCell(text: col4, isHeader: isHeader),
        ],
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const _TableCell({required this.text, this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16 : 14,
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
