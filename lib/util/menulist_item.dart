import 'package:flutter/material.dart';
import 'package:yous_app/models/repository.dart';

class MenulistItem extends StatelessWidget {
  final String menuName;
  final String price;
  final String? image;

  const MenulistItem({
    super.key,
    required this.menuName,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  color: Colors.white,
                  child: Image.network(
                    Repository().urlApi + (image ?? ''),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noimage.jpg', // Default fallback image
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.5, // Set a fixed width constraint
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        menuName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$price ກິບ',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        size: 12,
                        color: Color.fromARGB(255, 247, 192, 9),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // Add functionality here if needed
            },
            icon: const Icon(
              Icons.reviews,
              size: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
