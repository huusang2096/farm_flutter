import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:shimmer/shimmer.dart';

class TreeProductsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: GridView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              child: Container(
                width: 80.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          );
        },
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: row,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.90,
        ),
      ),
    );
  }
}
