
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleState extends GetxController {
  updateLang(Locale locale) {
    Get.locale = locale;
    update();
  }
}

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.textDecoration,
      this.shadows,
      this.useTranslate = true})
      : super(key: key);
  final String text;
  final double? fontSize;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final List<Shadow>? shadows;
  final bool useTranslate;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleState>(builder: (localeUpdate) {
      return Text(
        useTranslate ? text.tr : text,
        textAlign: textAlign,
        style: TextStyle(
          decoration: textDecoration ?? TextDecoration.none,
          // fontSize: Platform.isAndroid
          //     ? Get.locale == const Locale('en', 'US')
          //         ? fontSize != null
          //             ? fontSize! - 1.5
          //             : fontSize
          //         : fontSize
          //     :

          fontSize: fontSize,
          color: color,
          shadows: shadows,
          fontFamily: "NotoSan",
          fontWeight: fontWeight,
        ),
      );
    });
  }
}
