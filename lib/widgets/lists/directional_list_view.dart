import 'package:flutter/material.dart';

class DirectionalListView<T> extends StatelessWidget {
  final String sectionTitle;
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final double listHeight;
  final bool isLoading;
  final String error;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? titlePadding;
  final bool showEmptyMessage;
  final String emptyMessage;
  final double verticalListHeight;

  const DirectionalListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.sectionTitle = 'Featured Products',
    this.listHeight = 200,
    this.isLoading = false,
    this.error = '',
    this.scrollDirection = Axis.horizontal,
    this.padding,
    this.titlePadding,
    this.showEmptyMessage = true,
    this.emptyMessage = 'No items available',
    this.verticalListHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error.isNotEmpty) {
      return Center(
        child: Text('Error: $error', style: const TextStyle(color: Colors.red)),
      );
    }

    if (items.isEmpty && showEmptyMessage) {
      return Center(child: Text(emptyMessage));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Don't take more space than needed
      children: [
        if (sectionTitle.isNotEmpty)
          Padding(
            padding:
                titlePadding ??
                (scrollDirection == Axis.horizontal
                    ? const EdgeInsets.only(left: 16, bottom: 10)
                    : const EdgeInsets.only(left: 16, bottom: 10)),
            child: Text(
              sectionTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        _buildListContainer(),
      ],
    );
  }

  Widget _buildListContainer() {
    // Use appropriate container based on scroll direction
    if (scrollDirection == Axis.horizontal) {
      return SizedBox(height: listHeight, child: _buildListView());
    } else {
      // For vertical lists, we need a fixed height container
      return LimitedBox(maxHeight: verticalListHeight, child: _buildListView());
    }
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap:
          scrollDirection == Axis.vertical, // Important for vertical lists
      scrollDirection: scrollDirection,
      physics: const BouncingScrollPhysics(),
      padding:
          padding ??
          (scrollDirection == Axis.horizontal
              ? const EdgeInsets.symmetric(horizontal: 16)
              : const EdgeInsets.symmetric(vertical: 8)),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}
