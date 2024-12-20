import 'package:flutter/material.dart';
import 'package:yous_app/states/app_colors.dart';

class ReviewFood extends StatelessWidget {
  final String name ;
  final String food_images;
  final String user_image;

  const ReviewFood({Key? key,
  required this.food_images,
  required this.user_image,
  required this.name,


  });

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return 
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              food_images,
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.0), // Adjust the padding as needed
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    0, 107, 93, 93), // Set the color to transparent
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: appColors.mainColor, // Set the border color
                          width: 3, // Set the border width
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          user_image,
                         
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
