import 'package:flutter/material.dart';
import 'package:recipe_circle/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/widgets/cards/small_popular_card.dart';
import 'package:recipe_circle/widgets/lists/products_directional_list.dart';
import 'package:recipe_circle/widgets/sections/ingredients_section.dart';
import 'package:recipe_circle/widgets/sections/instructions_section.dart';
import 'dart:math';

int getRandomInt(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min);
}

class ItemScreen extends StatefulWidget {
  final Product product;

  const ItemScreen({super.key, required this.product});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool showFullDescription = false;
  int _selectedTab = 0;
  Map<int, int> _ingredientCounts = {};

  late List<Product> _ingredients;
  late int _ingredientCount;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _initializeIngredients(BuildContext context) {
    if (!_initialized) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      _ingredientCount = getRandomInt(3, 7);

      final List<Product> allProducts = productProvider.products;
      _ingredients =
          allProducts.length > _ingredientCount
              ? allProducts.sublist(0, _ingredientCount)
              : allProducts;

      for (var product in _ingredients) {
        _ingredientCounts[product.id] = 1;
      }

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final isFavorite = productProvider.isFavorite(widget.product);

    final relatedProducts =
        productProvider.products
            .where(
              (p) =>
                  p.category == widget.product.category &&
                  p.id != widget.product.id,
            )
            .toList();

    _initializeIngredients(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.fitHeight,
                        errorBuilder:
                            (context, error, stackTrace) => const Center(
                              child: Icon(Icons.image_not_supported, size: 80),
                            ),
                      ),
                    ),
                  ),

                  // Gradient overlay
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 70,
                    left: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/imgs/cross.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 70,
                    right: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          productProvider.toggleFavorite(widget.product);
                        },
                        child: Image.asset(
                          isFavorite
                              ? 'assets/imgs/heart_filled.png'
                              : 'assets/imgs/heart_unfilled.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Transform.translate(
                offset: const Offset(0, -20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text(
                                  widget.product.title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '\$${widget.product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/imgs/property1.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "1.5m",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 70),
                                  Image.asset(
                                    'assets/imgs/property2.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "500 g",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/imgs/property3.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "1 GB",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 70),
                                  Image.asset(
                                    'assets/imgs/property4.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "9 V",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          Center(
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedTab = 0;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              _selectedTab == 0
                                                  ? const Color(0xFF042628)
                                                  : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 25,
                                        ),
                                        child: Text(
                                          'Ingredients',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                _selectedTab == 0
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedTab = 1;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              _selectedTab == 1
                                                  ? const Color(0xFF042628)
                                                  : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 25,
                                        ),
                                        child: Text(
                                          'Instructions',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                _selectedTab == 1
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          _selectedTab == 0
                              ? IngredientsSection(
                                ingredients: _ingredients,
                                initialCounts: _ingredientCounts,
                              )
                              : const InstructionsSection(),

                          const SizedBox(height: 50),

                          ProductsDirectionalList(
                            sectionTitle: "Related Products",
                            products: relatedProducts,
                            height: 150,
                            itemBuilder:
                                (product, index) =>
                                    SmallPopularCard(product: product),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
