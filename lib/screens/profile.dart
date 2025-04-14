import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_circle/providers/product_provider.dart';
import 'package:recipe_circle/widgets/cards/popular_card.dart';
import 'package:recipe_circle/screens/item.dart'; // Add import for ItemScreen

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final favorites = productProvider.favorites;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/imgs/settings.png',
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/imgs/M.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Midhun Unni",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Product Designer",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF48525F),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 80),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 59, 59, 59),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Favorites',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF70B9BE),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Expanded(
                child:
                    favorites.isEmpty
                        ? const Center(child: Text('No favorites yet'))
                        : Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.75,
                                ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final product = favorites[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ItemScreen(product: product),
                                    ),
                                  );
                                },
                                child: PopularCard(
                                  product: product,
                                  showCategory: true,
                                ),
                              );
                            },
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
