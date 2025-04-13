import 'package:flutter/material.dart';
import 'package:recipe_circle/models/product_model.dart';

class SmallPopularCard extends StatelessWidget {
  final Product product;

  const SmallPopularCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 136,
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
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      margin: const EdgeInsets.only(right: 15, bottom: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
