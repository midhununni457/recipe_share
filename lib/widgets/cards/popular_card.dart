import 'package:flutter/material.dart';
import 'package:recipe_circle/models/product_model.dart';

class PopularCard extends StatelessWidget {
  final Product product;

  const PopularCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      margin: const EdgeInsets.only(right: 15, bottom: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 168,
            height: 128,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.network(
              product.image,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.error),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value:
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "\$ ${product.price}",
                style: const TextStyle(
                  color: Color(0xFF97A2B0),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Color(0xFF97A2B0),
                  shape: BoxShape.circle,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    fill: 0.0,
                    color: Color.fromARGB(255, 252, 228, 74),
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    product.rating.rate.toString(),
                    style: const TextStyle(
                      color: Color(0xFF97A2B0),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
