import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/widgets/cards/featured_card.dart';
import 'package:recipe_circle/widgets/cards/popular_card.dart';
import 'package:recipe_circle/widgets/categories/category_selector.dart';
import 'package:recipe_circle/widgets/lists/products_directional_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final filteredProducts = productProvider.getHomeProducts();
    final featuredProducts = productProvider.products.take(6).toList();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/imgs/sun.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Good Morning',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Midhun Unni',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  'assets/imgs/cart.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductsDirectionalList(
                sectionTitle: "Featured",
                height: 172,
                products: featuredProducts,
                itemBuilder: (product, index) => FeaturedCard(product: product),
              ),
              const SizedBox(height: 25),

              const CategorySelector(
                sectionTitle: "Category",
                screenType: CategoryScreenType.home,
              ),
              const SizedBox(height: 25),

              ProductsDirectionalList(
                sectionTitle: "Popular Products",
                height: 250,
                products: filteredProducts,
                itemBuilder: (product, index) => PopularCard(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
