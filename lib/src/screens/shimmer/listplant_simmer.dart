import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simplest/simplest.dart';

class ListPlantShimmer extends StatefulWidget {
  @override
  _ListPlantShimmerState createState() => _ListPlantShimmerState();
}

class _ListPlantShimmerState extends State<ListPlantShimmer> {
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
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 0.9,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                height: 100,
              ),
            );
          },
        ),
      ),
    );
  }
}
