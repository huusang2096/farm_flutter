import 'package:farmgate/src/model/review/ImageSelect.dart';
import 'package:farmgate/src/screens/graden/addGarden/bloc/add_garden_cubit.dart';
import 'package:farmgate/src/screens/graden/addGarden/widget/image_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ImageReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddGardenCubit bloc = context.watch<AddGardenCubit>();

    return GridView.builder(
      shrinkWrap: true,
      itemCount: bloc.state.data.imageSelects.length,
      physics: NeverScrollableScrollPhysics(),
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        ImageSelect image = bloc.state.data.imageSelects.elementAt(index);
        return ImageItemWidget(
          imageSelect: image,
          onSelectDelete: (image) {
            bloc.deleteImage(image);
          },
        );
      },
    );
  }
}
