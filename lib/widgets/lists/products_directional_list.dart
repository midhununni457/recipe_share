import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/models/product_model.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/widgets/cards/featured_card.dart';
import 'package:recipe_circle/widgets/lists/directional_list_view.dart';

class ProductsDirectionalList extends StatelessWidget {
  final String sectionTitle;
  final List<Product>? products;
  final Widget Function(Product product, int index)? itemBuilder;
  final double? height;
  final Axis scrollDirection;
  final double verticalListHeight;

  const ProductsDirectionalList({
    required this.sectionTitle,
    this.products,
    this.itemBuilder,
    this.height,
    this.scrollDirection = Axis.horizontal,
    this.verticalListHeight = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final productsList = products ?? productProvider.products;

    return DirectionalListView<Product>(
      sectionTitle: sectionTitle,
      items: productsList,
      listHeight: height ?? 200,
      verticalListHeight: verticalListHeight,
      isLoading: productProvider.isLoading,
      error: productProvider.error,
      scrollDirection: scrollDirection,
      padding:
          scrollDirection == Axis.horizontal
              ? const EdgeInsets.symmetric(horizontal: 10)
              : const EdgeInsets.only(bottom: 10),
      titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
      itemBuilder: (context, product) {
        final index = productsList.indexOf(product);
        return itemBuilder != null
            ? itemBuilder!(product, index)
            : FeaturedCard(product: product);
      },
    );
  }
}
