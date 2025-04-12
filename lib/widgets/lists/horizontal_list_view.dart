import 'package:flutter/material.dart';

class HorizontalListView<T> extends StatelessWidget {
  final String sectionTitle;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final double listHeight;
  final bool isLoading;
  final String error;

  const HorizontalListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.sectionTitle = 'Featured Products',
    this.listHeight = 200,
    this.isLoading = false,
    this.error = '',
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error.isNotEmpty) {
      return Center(
        child: Text('Error: $error', style: TextStyle(color: Colors.red)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 10),
          child: Text(
            sectionTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return itemBuilder(context, items[index]);
            },
          ),
        ),
      ],
    );
  }
}
