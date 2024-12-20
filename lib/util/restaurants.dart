import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yous_app/models/repository.dart';
import 'package:yous_app/states/app_colors.dart';

class Restaurants extends StatelessWidget {
  final int? id;
  final int? menu;
  final String? backgroundImg;
  final String? logoImg;
  final String? name;
  final String? status;
  final String? village;

  const Restaurants({
    Key? key,
    this.id,
    this.menu,
    this.backgroundImg,
    this.logoImg,
    this.name,
    this.status,
    this.village,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), // Shadow color with transparency
                offset: Offset(2, 2), // Horizontal and vertical offset
                blurRadius: 4, // Blur radius
                spreadRadius: 3, // Spread radius
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      Repository().urlApi + backgroundImg.toString(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) {
                        // Default image to show when the network image fails
                        return Image.asset(
                          'assets/bg.png', // Path to your default image
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 120,
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.symmetric(
                            //           vertical: 5, horizontal: 10),
                            //       decoration: BoxDecoration(
                            //           color: Color.fromARGB(190, 58, 58, 58)),
                            //       child: Text(
                            //         status.toString(),
                            //         style: TextStyle(
                            //             color: status == 'ເປິດ'
                            //                 ? Colors.green
                            //                 : Colors.red,
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.symmetric(
                            //           horizontal: 8, vertical: 1),
                            //       decoration: BoxDecoration(
                            //           color: Color.fromARGB(131, 58, 58, 58),
                            //           borderRadius: BorderRadius.circular(2)),
                            //       child: Row(
                            //         children: [
                            //           Icon(
                            //             Icons.star,
                            //             size: 14,
                            //             color:
                            //                 Color.fromARGB(255, 250, 174, 11),
                            //           ),
                            //           Text(
                            //             '4.5',
                            //             style:
                            //                 TextStyle(color: appColors.white),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name.toString() + ' (${village})',
                            style: TextStyle(
                              fontSize: 16,
                              color: appColors.black1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: appColors.grey1,
                              ),
                              Text(
                                // '900 M - 25 ນາທີ',
                                'no',
                                style: TextStyle(
                                    color: appColors.grey1, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          menu.toString() + 'food_list'.tr,
                          style:
                              TextStyle(color: appColors.grey1, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
