import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TagsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.7),
        itemBuilder: (context, index) {
          return Container(
            height: 16,
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
          );
        },
      ),
    );
  }
}
