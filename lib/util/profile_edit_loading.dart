import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileEditLoading extends StatelessWidget {
  const ProfileEditLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Profile Picture Shimmer
          Center(
            child: Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 255, 255, 255),
              highlightColor: Color.fromARGB(157, 214, 214, 214),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Container(
                  width: 120,
                  height: 120,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // List of Shimmer Containers (e.g., for input fields)
          ListView.builder(
            shrinkWrap: true, // Prevents ListView from taking full height
            physics:
                NeverScrollableScrollPhysics(), // Prevents scrolling inside ListView
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 255, 255, 255),
                    highlightColor: Color.fromARGB(157, 214, 214, 214),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 15,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
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
                  SizedBox(height: 20),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
