import 'package:farmgate/routes.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/screens/manager_project/cubit/cubit/manager_project_cubit.dart';
import 'package:farmgate/src/screens/shimmer/action_simmer.dart';
import 'package:farmgate/src/widgets/dotted_line.dart';
import 'package:farmgate/src/widgets/reload_widget.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class ManagerProjectScreen
    extends CubitWidget<ManagerProjectCubit, ManagerProjectState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static provider() {
    return BlocProvider(
      create: (_) => ManagerProjectCubit(),
      child: ManagerProjectScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<ManagerProjectCubit>().getMyProject();
    context.read<ManagerProjectCubit>().setupNotification();
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, ManagerProjectState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, ManagerProjectState state) {
    final Size _size = MediaQuery.of(context).size;

    void _onRefresh() async {
      context.read<ManagerProjectCubit>().getMyProject();
      _refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SmartRefresher(
              controller: _refreshController,
              header: ReloadWidget(),
              enablePullDown: true,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                  child: state.data.isLoading
                      ? ActionShimmer()
                      : _buildListData(context, state))),
        ),
      ),
    );
  }

  Widget _buildListData(BuildContext context, ManagerProjectState state) {
    return state.data.myProjects == null
        ? buildEmptyProject(context)
        : Container(
            child: ListView.separated(
              separatorBuilder: (context, _) => SizedBox(height: 12),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: state.data.myProjects.length,
              itemBuilder: (context, index) {
                MyProject item = state.data.myProjects.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    context.read<ManagerProjectCubit>().openDetail(item);
                  },
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    '${'project'.tr} ${item.project.name}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: titleNew.copyWith(fontSize: 20),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    item.project.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: descNew,
                                  ),
                                  SizedBox(height: 5),
                                  AutoSizeText(
                                    item.project.address,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: descNew.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            DottedLine(height: 1, color: Colors.grey),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: item.status == 'not_eligible_for_review'
                                  ? () {
                                      _showModalBottomSheet(context);
                                    }
                                  : () {},
                              child: Center(
                                child: Text(
                                  //update approval reason
                                  item.status == "pending"
                                      ? 'pending'.tr
                                      : item.status ==
                                              'not_eligible_for_review'.tr
                                          ? 'not_eligible_for_review'.tr
                                          : 'published'.tr,
                                  textAlign: TextAlign.center,
                                  //if type = published, color is activeGreen and others is red
                                  style: titleBar.copyWith(
                                      color: item.status != "published"
                                          ? redColor
                                          : activeGreen),
                                ),
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
          );
  }

  Container buildEmptyProject(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.grey,
                            Colors.grey.withOpacity(0.1),
                          ])),
                  child: SvgPicture.asset(
                    'assets/images/presentation.svg',
                    color: beginGradientColor,
                    height: 30,
                    width: 30,
                  )),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Text(
            'my_project_empty'.tr,
            style: textInput,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Center(
            child: FlatButton(
                onPressed: () {
                  navigator.pushNamed(AppRoute.allProject).then((value) =>
                      {context.read<ManagerProjectCubit>().getMyProject()});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: appIconColor,
                      borderRadius: new BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    'join_project'.tr,
                    style: title.copyWith(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(color: greyColor),
      elevation: 1.0,
      title: Text(
        'manager_project'.tr,
        style: headingBlack18,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(
              Icons.post_add_outlined,
              color: beginGradientColor,
              size: 30,
            ),
            onPressed: () {
              navigator.pushNamed(AppRoute.allProject).then((value) =>
                  {context.read<ManagerProjectCubit>().getMyProject()});
            },
          ),
        )
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 10),
                curve: Curves.decelerate,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 60,
                            height: 5,
                          ),
                          Container(
                            width: 60,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20, top: 20),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                gradient: linearGradient,
                              ),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('reason_not_approval'.tr,
                            style: titleNew.copyWith(color: Colors.black)),
                      ),
                      SizedBox(height: 15),
                      Container(height: 5, color: backgroundColor),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          children: [
                            Text('reason 1: ...',
                                style: body1.copyWith(color: Colors.black)),
                            Text('reason 2: ...',
                                style: body1.copyWith(color: Colors.black)),
                            Text('reason 3: ...',
                                style: body1.copyWith(color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
