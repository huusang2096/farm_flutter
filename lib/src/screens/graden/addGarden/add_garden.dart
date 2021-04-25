import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:farmgate/src/screens/graden/addGarden/widget/image_review_widget.dart';
import 'package:farmgate/src/screens/graden/addGarden/widget/map_widget.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/empty_account.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

import '../../../../locator.dart';
import 'bloc/add_garden_cubit.dart';
import 'bloc/add_garden_state.dart';

class AddGardenScreen extends CubitWidget<AddGardenCubit, AddGardensState> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();
  final _appPref = locator<AppPref>();

  static provider() {
    return BlocProvider(
        create: (context) => AddGardenCubit(), child: AddGardenScreen());
  }

  @override
  void listener(BuildContext context, AddGardensState state) {
    super.listener(context, state);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    context.read<AddGardenCubit>().addImage(null);
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, AddGardensState state) {
    Size _size = MediaQuery.of(context).size;
    return AppProgressHUB(
      inAsyncCall: state.data.isLoading,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: greyColor),
            title: LogoWidget(
              urlImg: Images.logoIcon,
              bottom: 0,
            ),
            centerTitle: true,
            elevation: 1.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    icon: Icon(Icons.check, size: 30, color: appIconColor),
                    onPressed: () {
                      context.read<AddGardenCubit>().postData(
                          _titleController.text.toString(),
                          _descController.text.toString(),
                          _descController.text.toString());
                    }),
              )
            ],
          ),
          body: _appPref.token.isEmpty
              ? EmptyAccount()
              : SafeArea(
                  child: Container(
                  color: backgroundColor,
                  height: _size.height,
                  width: _size.width,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      SizedBox(height: 20),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 1,
                              controller: _titleController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1.6, color: appIconColor)),
                                hintText: 'title_add_garden'.tr,
                              ))),
                      SizedBox(height: 20),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 4,
                              keyboardType: TextInputType.text,
                              controller: _descController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.0, color: Colors.transparent)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.red)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 1.6, color: appIconColor)),
                                hintText: 'des_add_garden'.tr,
                              ))),
                      SizedBox(height: 25),
                      MapWidget(),
                      state.data.myPlace != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      new BorderRadius.all(Radius.circular(8)),
                                  gradient: linearGradient),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.data.myPlace.formattedAddress ?? "",
                                    maxLines: 2,
                                    style:
                                        textInput.copyWith(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('list_image_review'.tr, style: textInput),
                            SizedBox(height: 10),
                            ImageReviewWidget(),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  )),
                ))),
    );
  }
}
