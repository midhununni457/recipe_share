import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/widgets/cards/horizontal_card.dart';
import 'package:recipe_circle/widgets/cards/small_popular_card.dart';
import 'package:recipe_circle/widgets/categories/category_selector.dart';
import 'package:recipe_circle/widgets/lists/products_directional_list.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final filteredProducts = productProvider.getSearchProducts();
    final designersChoiceProducts =
        productProvider.products
            .where((product) => product.category == "women's clothing")
            .take(5)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back),
              Text(
                'Search',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Image.asset(
                    'assets/imgs/search_unfilled.png',
                    color: Colors.black,
                    width: 20,
                    height: 20,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
            const SizedBox(height: 20),
            const CategorySelector(
              sectionTitle: "",
              screenType: CategoryScreenType.search,
            ),
            const SizedBox(height: 25),
            ProductsDirectionalList(
              sectionTitle: "Popular Products",
              height: 150,
              products: filteredProducts,
              itemBuilder:
                  (product, index) => SmallPopularCard(product: product),
            ),
            const SizedBox(height: 30),
            ProductsDirectionalList(
              sectionTitle: "Designer's Choice",
              scrollDirection: Axis.vertical,
              products: designersChoiceProducts,
              verticalListHeight: 260,
              itemBuilder: (product, index) => HorizontalCard(product: product),
            ),
          ],
        ),
      ),
    );
  }
}
