import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/screens/manager_project/all_project/cubit/all_project_cubit.dart';
import 'package:farmgate/src/screens/manager_project/all_project/widget/item_member_widget.dart';
import 'package:farmgate/src/screens/shimmer/action_simmer.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:farmgate/src/widgets/dotted_line.dart';
import 'package:farmgate/src/widgets/empty_news_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class AllProjectScreen extends CubitWidget<AllProjectCubit, AllProjectState> {
  String userTypeText = '';

  static provider() {
    return BlocProvider(
      create: (context) => AllProjectCubit(),
      child: AllProjectScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    context.read<AllProjectCubit>().getAllProject();
    super.afterFirstLayout(context);
  }

  @override
  Widget builder(BuildContext context, AllProjectState state) {
    final Size _size = MediaQuery.of(context).size;
    final listProject = state?.data?.allProjectResponse?.data;
    return AppProgressHUB(
      inAsyncCall: state.data.isAdd,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              height: _size.height,
              width: _size.width,
              child: state.data.isLoading
                  ? ActionShimmer()
                  : listProject == null
                      ? EmptyNewWidget()
                      : ListView.separated(
                          separatorBuilder: (context, _) =>
                              SizedBox(height: 12),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: state.data.allProjectResponse.data.length,
                          itemBuilder: (context, index) {
                            Project item = state.data.allProjectResponse.data
                                .elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                /*_showModalBottomSheetInfoDetailProject(
                                    context, _size, state, item);*/
                                context
                                    .read<AllProjectCubit>()
                                    .joinProject(item.id);
                              },
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                '${'project'.tr} ${item.name}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                                style: titleNew.copyWith(
                                                    fontSize: 20),
                                              ),
                                              SizedBox(height: 5),
                                              Text(item.description,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: descNew),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AutoSizeText(
                                                    'project_address'.tr,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: descNew.copyWith(
                                                        color:
                                                            beginGradientColor),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      item.address,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                      style: descNew,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AutoSizeText(
                                                    'project_start_at'.tr,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                    style: descNew.copyWith(
                                                        color:
                                                            beginGradientColor),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: AutoSizeText(
                                                      fullDateFormatter.format(
                                                          DateTime.parse(
                                                              item.createdAt)),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                      style: descNew,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        DottedLine(
                                            height: 1, color: Colors.grey),
                                        SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            'add_project'.tr,
                                            style: titleBar.copyWith(
                                                color: activeGreen),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      elevation: 1.0,
      title: Text(
        'all_project'.tr,
        style: headingBlack18,
      ),
      centerTitle: true,
    );
  }

  _showModalBottomSheetInfoDetailProject(
      BuildContext context, Size size, AllProjectState state, Project item) {
    showModalBottomSheet(
      context: context,
      elevation: 10.0,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: Duration(milliseconds: 10),
              curve: Curves.decelerate,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ItemMemberWidget.provider(item),
              ),
            );
          },
        );
      },
    );
  }
}
