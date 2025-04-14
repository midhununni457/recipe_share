import 'package:flutter/material.dart';
import 'package:recipe_circle/models/product_model.dart';

class IngredientCard extends StatelessWidget {
  final Product product;
  final int count;
  final Function(int) onCountChanged;

  const IngredientCard({
    Key? key,
    required this.product,
    required this.count,
    required this.onCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color removeButtonColor =
        count > 1 ? const Color(0xFF70B9BE) : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 48,
                    height: 48,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Row(
            children: [
              InkWell(
                onTap: () {
                  if (count > 1) {
                    onCountChanged(count - 1);
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: removeButtonColor, width: 1),
                  ),
                  child: Icon(Icons.remove, size: 18, color: removeButtonColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onCountChanged(count + 1);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFF70B9BE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: Color(0xFF70B9BE),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
