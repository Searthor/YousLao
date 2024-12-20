import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/states/app_colors.dart';
import 'package:yous_app/states/history_state.dart';
import 'package:yous_app/util/history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryState historyState = HistoryState();

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    setState(() {
      historyState.isLoading = true;
    });
    await historyState.getHistorys();
    setState(() {
      historyState.isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    await _fetchHistory(); // Re-fetch the data
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    AppColors appColors = AppColors();
    return Scaffold(
      backgroundColor: appColors.mainColor,
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: Text(
          'transaction_history'.tr,
          style: TextStyle(color: appColors.backgroundColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: historyState.isLoading
            ? ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 255, 255, 255),
                        highlightColor:
                            const Color.fromARGB(157, 214, 214, 214),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: 90,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              )
            : historyState.historydata.isEmpty
                ? const Center(
                    child: Text('No data available'),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshData, // Triggered on pull-down
                    child: ListView.builder(
                      itemCount: historyState.historydata.length,
                      itemBuilder: (context, index) {
                        final item = historyState.historydata[index];
                        return Column(
                          children: [
                            HistoryItem(item: item),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
