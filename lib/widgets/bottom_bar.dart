import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
            spreadRadius: 1,
          ),
        ],
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 8.0,
        color: Colors.white,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side icons
              IconButton(
                icon: Image.asset(
                  selectedIndex == 0
                      ? 'assets/imgs/home_filled.png'
                      : 'assets/imgs/home_unfilled.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => onItemSelected(0),
              ),
              IconButton(
                icon: Image.asset(
                  selectedIndex == 1
                      ? 'assets/imgs/search_filled.png'
                      : 'assets/imgs/search_unfilled.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => onItemSelected(1),
              ),
              SizedBox(width: 24),
              // Right side icons
              IconButton(
                icon: Image.asset(
                  'assets/imgs/notifications.png',
                  width: 24,
                  height: 24,
                  color: selectedIndex == 2 ? const Color(0xFF70B9BE) : null,
                ),
                onPressed: () => onItemSelected(2),
              ),
              IconButton(
                icon: Image.asset(
                  selectedIndex == 3
                      ? 'assets/imgs/profile_filled.png'
                      : 'assets/imgs/profile_unfilled.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => onItemSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
