import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/providers/product_provider.dart';

enum CategoryScreenType { home, search }

class CategorySelector extends StatelessWidget {
  final String sectionTitle;
  final CategoryScreenType screenType;

  const CategorySelector({
    required this.sectionTitle,
    this.screenType = CategoryScreenType.home,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final displayedCategories = productProvider.displayedCategories;
    final selectedCategoryId =
        screenType == CategoryScreenType.home
            ? productProvider.homeSelectedCategoryId
            : productProvider.searchSelectedCategoryId;
    final showAllCategories = productProvider.showAllCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sectionTitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    productProvider.toggleShowAllCategories();
                  },
                  child: Text(
                    showAllCategories ? "See Less" : "See All",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF70B9BE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 5),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayedCategories.length,
            padding: const EdgeInsets.symmetric(vertical: 2),
            itemBuilder: (context, index) {
              final category = displayedCategories[index];
              final isSelected = category.id == selectedCategoryId;

              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 10 : 5,
                  right: index == displayedCategories.length - 1 ? 10 : 5,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (screenType == CategoryScreenType.home) {
                      productProvider.selectHomeCategory(category.id);
                    } else {
                      productProvider.selectSearchCategory(category.id);
                    }

                    if (!productProvider.showAllCategories &&
                        index >= 3 &&
                        productProvider.categories.length > 3) {
                      productProvider.toggleShowAllCategories();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSelected ? const Color(0xFF70B9BE) : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color:
                            isSelected
                                ? Colors.transparent
                                : Colors.grey.shade300,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(category.name, style: TextStyle(fontSize: 16)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
