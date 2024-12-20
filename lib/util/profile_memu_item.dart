import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/util/constants.dart';

class ProfileMenuItem extends StatelessWidget {
  final Icon icon;
  final bool next_plan;
  final String text;
  final VoidCallback? onTap;
  const ProfileMenuItem(
      {super.key,
      required this.icon,
      required this.text,
      this.onTap,
      this.next_plan = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(padding: EdgeInsets.all(2), child: icon),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: appColors.grey1,
                  ),
                ),
              ],
            ),
            if (next_plan) // Show icon only if nextPlan is true
              const Icon(
                Icons.next_plan,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
