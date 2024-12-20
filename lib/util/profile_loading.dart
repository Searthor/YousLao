import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Center(
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 255, 255, 255),
              highlightColor: Color.fromARGB(157, 214, 214, 214),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 70,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 70,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 20,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 255, 255, 255),
              highlightColor: Color.fromARGB(157, 214, 214, 214),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 50,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 255, 255, 255),
              highlightColor: Color.fromARGB(157, 214, 214, 214),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 50,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
