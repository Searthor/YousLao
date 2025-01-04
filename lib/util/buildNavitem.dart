import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yous_app/pages/profile_page.dart';

class BuildNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const BuildNavItem({super.key,required this.icon ,required this.label,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:  Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                color:Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}