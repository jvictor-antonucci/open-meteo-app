import 'package:flutter/material.dart';

class SearchCountryChipsDelegate extends SliverPersistentHeaderDelegate {
  final double height;

  const SearchCountryChipsDelegate({required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => Chip(label: Text('Country')),
      scrollDirection: Axis.horizontal,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return this != oldDelegate;
  }
}
