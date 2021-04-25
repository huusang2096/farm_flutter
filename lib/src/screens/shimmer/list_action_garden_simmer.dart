import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simplest/simplest.dart';

class ListGardenShimmer extends StatefulWidget {
  @override
  _ListGardenShimmerState createState() => _ListGardenShimmerState();
}

class _ListGardenShimmerState extends State<ListGardenShimmer> {
  @override
  Widget build(BuildContext context) {
    int row = 2;
    if (Device.get().isTablet) {
      row = 4;
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: row,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                height: 80,
              ),
            );
          },
        ),
      ),
    );
  }
}
