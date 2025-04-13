import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/models/product_model.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/widgets/cards/featured_card.dart';

class ProductsHorizontalList extends StatelessWidget {
  final String sectionTitle;
  final List<Product>? products;
  final Widget Function(Product product, int index)? itemBuilder;
  final double? height;

  const ProductsHorizontalList({
    required this.sectionTitle,
    this.products,
    this.itemBuilder,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final productsList = products ?? productProvider.products;
    final isLoading = productProvider.isLoading;
    final error = productProvider.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (error.isNotEmpty)
          Center(child: Text('Error: $error'))
        else if (productsList.isEmpty)
          const Center(child: Text('No products available'))
        else
          Container(
            // If height is provided, use it, otherwise it will size to children
            constraints:
                height != null ? BoxConstraints(maxHeight: height!) : null,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.horizontal,
              itemCount: productsList.length,
              itemBuilder: (ctx, i) {
                return itemBuilder != null
                    ? itemBuilder!(productsList[i], i)
                    : FeaturedCard(product: productsList[i]);
              },
            ),
          ),
      ],
    );
  }
}
