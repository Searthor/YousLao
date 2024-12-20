import 'package:flutter/material.dart';
import 'package:yous_app/states/app_colors.dart';

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> _plantypes;
  final int selectIndex;
  final Function(int) onTap;

  StickyHeaderDelegate(this._plantypes, this.selectIndex, this.onTap);

  AppColors appColors = AppColors();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isPinned = shrinkOffset > 0 || overlapsContent;

    return Container(
      color: isPinned ? appColors.white : appColors.backgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _plantypes.asMap().entries.map((entry) {
            int index = entry.key;
            String plantType = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () => onTap(index),
                child: Column(
                  children: [
                    Text(
                      plantType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectIndex == index
                            ? FontWeight.bold
                            : FontWeight.w300,
                        color: selectIndex == index
                            ? Colors.blue // Adjust color as needed
                            : appColors.grey1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
