import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/review/ImageSelect.dart';
import 'package:farmgate/src/screens/addNew/bloc/add_news_cubit.dart';
import 'package:farmgate/src/screens/graden/addGarden/bloc/add_garden_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:simplest/simplest.dart';

class ImageItemWidget extends StatefulWidget {
  ImageSelect imageSelect;
  String currency;
  final Function(ImageSelect) onSelectDelete;

  ImageItemWidget(
      {Key key, this.imageSelect, this.currency, this.onSelectDelete})
      : super(key: key);

  @override
  _ImageItemWidgetState createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  File imagefile;
  String lastSelectedValue;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> loadAssets() async {
      List<Asset> resultList = List<Asset>();
      try {
        resultList = await MultiImagePicker.pickImages(
            maxImages: 10,
            enableCamera: false,
            selectedAssets: [],
            cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
            materialOptions: MaterialOptions(
                actionBarColor: "#008080",
                statusBarColor: "#008080",
                actionBarTitle: allTranslations.text('photo_library'),
                allViewTitle: allTranslations.text('all_photos'),
                useDetailsView: false,
                textOnNothingSelected:
                    allTranslations.text('no_image_selected'),
                selectionLimitReachedText:
                    allTranslations.text("limit_image_selected"),
                selectCircleStrokeColor: "#000000"));
        context.read<AddNewsCubit>().addMultiImage(resultList);
      } catch (e) {
        logger.e(e);
      }
      if (!mounted) return;
    }

    Future<ImageSource> showSelectImageSource(BuildContext context) async {
      FocusScope.of(context).unfocus();

      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('camera'.tr),
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('gallery'.tr),
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text('cancel'.tr),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        },
      );
    }

    void onSelectImageFromDevice(BuildContext context) async {
      final picker = ImagePicker();
      ImageSource source = await showSelectImageSource(context);

      if (source != null && source == ImageSource.camera) {
        final pickedFile = await picker.getImage(source: ImageSource.camera);
        if (pickedFile != null) {
          context.read<AddGardenCubit>().addImage(File(pickedFile.path));
        }
      } else if (source != null && source == ImageSource.gallery) {
        final pickedFile = await picker.getImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          context.read<AddGardenCubit>().addImage(File(pickedFile.path));
        }
      }
    }

    return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: InkWell(
          onTap: () {
            if (widget.imageSelect.url == null) {
              onSelectImageFromDevice(context);
            }
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: (widget.imageSelect.url == null &&
                        widget.imageSelect.imageUrl == null)
                    ? Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Image.asset('assets/images/photo.png',
                              color: Colors.white, width: 40),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: widget.imageSelect.url != null
                            ? Image.file(widget.imageSelect.url,
                                fit: BoxFit.cover)
                            : CachedNetworkImage(
                                imageUrl: widget.imageSelect.imageUrl,
                                fit: BoxFit.fill),
                      ),
              ),
              widget.imageSelect.url != null
                  ? Positioned(
                      top: 2,
                      right: 2,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<AddGardenCubit>()
                              .deleteImage(widget.imageSelect);
                        },
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            gradient: linearGradient,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                          ),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ));
  }
}
