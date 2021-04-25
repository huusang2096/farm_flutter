import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:farmgate/src/screens/addNew/bloc/add_news_cubit.dart';
import 'package:farmgate/src/screens/addNew/widget/image_review_widget.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/empty_account.dart';
import 'package:farmgate/src/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simplest/simplest.dart';

import '../../../locator.dart';
import 'bloc/add_news_state.dart';

class AddNewsScreen extends CubitWidget<AddNewsCubit, AddNewsState> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();
  final _appPref = locator<AppPref>();

  static provider() {
    return BlocProvider(
        create: (context) => AddNewsCubit(), child: AddNewsScreen());
  }

  @override
  void listener(BuildContext context, AddNewsState state) {
    super.listener(context, state);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    if (_appPref.token.isNotEmpty) {
      context.read<AddNewsCubit>().addImage(null);
      context.read<AddNewsCubit>().setCurrentLocation();
    }
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, AddNewsState state) {
    Size _size = MediaQuery.of(context).size;
    Widget addressWidget;
    if (state.data.myPlace == null) {
      addressWidget = Row(
        children: [
          SizedBox(width: 10),
          Expanded(
              child: Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 28.0,
            ),
          )),
          Container(
            child: Icon(
              Icons.location_on,
              color: Colors.white,
              size: 25.0,
            ),
            width: 40.0,
          ),
        ],
      );
    } else {
      addressWidget = Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoute.userPlaceScreen)
                      .then((value) => {
                            if (value != null)
                              {context.read<AddNewsCubit>().placeChange(value)}
                          });
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.data.myPlace?.formattedAddress ?? "",
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoute.userPlaceScreen)
                  .then((value) => {
                        if (value != null)
                          {context.read<AddNewsCubit>().placeChange(value)}
                      });
            },
            child: Container(
              child: Icon(
                Icons.location_on,
                color: Colors.white,
                size: 25.0,
              ),
              width: 40.0,
            ),
          ),
        ],
      );
    }
    return AppProgressHUB(
      inAsyncCall: state.data.isLoading,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Colors.grey),
            title: LogoWidget(
              urlImg: Images.logoIcon,
              bottom: 0,
            ),
            centerTitle: true,
            elevation: 1,
            actions: [
              _appPref.token.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          icon: Icon(
                            Icons.check,
                            color: appIconColor,
                            size: 30,
                          ),
                          onPressed: () {
                            context.read<AddNewsCubit>().postData(
                                _titleController.text.toString(),
                                _descController.text.toString(),
                                _descController.text.toString());
                          }),
                    )
                  : SizedBox.shrink()
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                hintText: 'title'.tr,
                              ))),
                      SizedBox(height: 20),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 8,
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
                                hintText: 'description'.tr,
                              ))),
                      SizedBox(height: 25),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 10),
                          child: Text('location_post'.tr)),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                            width: double.infinity,
                            height: _size.height * 0.08,
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8)),
                              gradient: linearGradient,
                            ),
                            child: addressWidget),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 16),
                            Text('image_post'.tr),
                            SizedBox(height: 10),
                            ImageReviewWidget(),
                          ],
                        ),
                      )
                    ],
                  )),
                ))),
    );
  }
}
