import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/routes.dart';
import 'package:yous_app/states/app_colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int changeSize = 0;
  AppColors appColor = AppColors();
  @override
   void initState() {
    super.initState();

    initSplash();
  }

  initSplash() async {
    await Future.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() {
        changeSize = 50;
      });
    }).then((value) async {
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        setState(() {
          changeSize = 100;
        });
      });
    }).then((value) async {
      await Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        Get.offNamed(Routes.home);
      });
    });
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      backgroundColor: appColor.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                width: size.width,
                height: (fixSize * 0.08) + changeSize,
                duration: const Duration(milliseconds: 300),
                child: Image.asset('assets/logo.png'),
              ),
              SizedBox(
                height: fixSize * 0.01,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                  child: Text('1.0.1')
              ),
            ],
          )
        ],
      ),
    );
  }
}