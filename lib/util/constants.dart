import 'package:flutter/material.dart';
import 'package:yous_app/states/app_colors.dart';


AppColors appColors =AppColors();
final kHintTextStyle = TextStyle(
  color:  appColors.grey1,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color:  appColors.grey1,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  // boxShadow: [
  //   BoxShadow(
  //     color: Color.fromARGB(255, 5, 159, 255),
  //     blurRadius: 6.0,
  //     offset: Offset(0, 1),
  //   ),
  // ],
);