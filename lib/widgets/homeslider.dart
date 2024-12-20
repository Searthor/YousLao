import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/states/slide_controller.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int myCurrentIndex = 0;
  final SlideController slideController = Get.put(SlideController());
  Repository repository = Get.put(Repository());

  @override
  void initState() {
    super.initState();
    slideController.getSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (slideController.isLoading.value) {
        return Center(
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 255, 255, 255),
            highlightColor: Color.fromARGB(157, 214, 214, 214),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 170,
                color: const Color.fromARGB(255, 255, 255, 255),
                width: double.infinity,
              ),
            ),
          ),
        );
      }

      if (slideController.slidedata.isEmpty) {
        return Image.asset(
          'assets/bg.png', // Path to your default image
          fit: BoxFit.cover,
          width: double.infinity,
          height: 120,
        );
      }

      return Column(
        children: [
          CarouselSlider(
            items: slideController.slidedata
                .map(
                  (slide) => Image.network(
                    Repository().urlApi + slide.image.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/bg.png', // Path to your default image
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                      );
                    },
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              height: 150,
              onPageChanged: (index, reason) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slideController.slidedata.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: myCurrentIndex == index
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
