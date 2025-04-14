import 'package:flutter/material.dart';
import 'package:recipe_circle/models/product_model.dart';
import 'package:recipe_circle/widgets/cards/ingredient_card.dart';

class IngredientsSection extends StatefulWidget {
  final List<Product> ingredients;
  final Map<int, int> initialCounts;

  const IngredientsSection({
    super.key,
    required this.ingredients,
    required this.initialCounts,
  });

  @override
  State<IngredientsSection> createState() => _IngredientsSectionState();
}

class _IngredientsSectionState extends State<IngredientsSection> {
  late Map<int, int> _ingredientCounts;

  @override
  void initState() {
    super.initState();
    _ingredientCounts = Map.from(widget.initialCounts);
  }

  void _updateCount(int productId, int newCount) {
    setState(() {
      _ingredientCounts[productId] = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All ingredients added to cart'),
                  ),
                );
              },
              child: const Text(
                'Add All to Cart',
                style: TextStyle(
                  color: Color(0xFF70B9BE),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            '${widget.ingredients.length} items',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),

        ...widget.ingredients.map((product) {
          final count = _ingredientCounts[product.id] ?? 1;
          return IngredientCard(
            product: product,
            count: count,
            onCountChanged: (newCount) => _updateCount(product.id, newCount),
          );
        }),

        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Added to cart')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF70B9BE),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
