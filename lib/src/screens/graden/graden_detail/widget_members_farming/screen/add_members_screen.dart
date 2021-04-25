import 'package:farmgate/src/common/style.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/cubit/add_members_cubit.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/custom_network_image.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/dropdown_gender.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:farmgate/src/widgets/app_progress_hub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:simplest/simplest.dart';

class AddMembersScreen extends CubitWidget<AddMemberCubit, AddMembersState> {
  static BlocProvider<AddMemberCubit> provider(
      Member member, String status, int idGarden) {
    return BlocProvider(
        child: AddMembersScreen(),
        create: (context) => AddMemberCubit(member, status, idGarden));
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDes = TextEditingController();
  final TextEditingController _textControllerBirthDay = TextEditingController();
  final TextEditingController _textControllerBirthDayFormat =
      TextEditingController();
  final TextEditingController _textControllerRelationsShip =
      TextEditingController();
  final TextEditingController _textControllerJob = TextEditingController();
  final TextEditingController _textControllerEducation =
      TextEditingController();
  final double width = 145.0;
  final double height = 145.0;

  @override
  void afterFirstLayout(BuildContext context) {
    if (context.read<AddMemberCubit>().state.data.status ==
            StatusAddMember.EDIT_MEMBER ||
        context.read<AddMemberCubit>().state.data.status ==
            StatusAddMember.EDIT_PEOPLE) {
      final data = context.read<AddMemberCubit>().state.data;
      _controllerName.text = data.member.name;
      _controllerDes.text = data.member.description;
      _textControllerRelationsShip.text = data.member.relation;
      _textControllerJob.text = data.member.job;
      _textControllerEducation.text = data.member.education;
      data?.member?.dob == null
          ? _textControllerBirthDay.text = ''
          : _textControllerBirthDay.text =
              context.read<AddMemberCubit>().formatDate(data.member.dob);
      data?.member?.dob == null
          ? _textControllerBirthDayFormat.text = ''
          : _textControllerBirthDayFormat.text =
              DateFormat('yyyy-MM-dd').format(data.member.dob);
    }
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, AddMembersState state) {
    state.when(
        success: (data) {},
        loaded: (data) {},
        loading: (data) {},
        init: (data) {},
        addSuccess: (data) {
          _controllerName.clear();
          _controllerDes.clear();
          _textControllerBirthDay.clear();
          _textControllerRelationsShip.clear();
          _textControllerJob.clear();
          _textControllerEducation.clear();
          _textControllerBirthDayFormat.clear();
          context.read<AddMemberCubit>().clearImage();
        });
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, AddMembersState state) {
    return WillPopScope(
      onWillPop: context.watch<AddMemberCubit>().handlePop,
      child: AppProgressHUB(
        inAsyncCall: state.data.isLoading,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: _buildAppBar(context),
            backgroundColor: whiteColor,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 180.0,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: state.data.imgTemp != null
                                    ? CustomNetworkImageOrFileWidget(
                                        height: height,
                                        width: width,
                                        fileImg: state.data.imgTemp,
                                      )
                                    : CustomNetworkImageOrFileWidget(
                                        height: height,
                                        width: width,
                                        url: state.data.member?.image ??
                                            'https://ict-imgs.vgcloud.vn/2020/09/01/19/huong-dan-tao-facebook-avatar.jpg',
                                      ),
                              ),
                              _iconEdit(
                                  onPress: () =>
                                      context.read<AddMemberCubit>().pickFile(),
                                  context: context)
                            ],
                          ),
                        ),
                        _customTextField(
                            controller: _controllerName,
                            hintText: 'name'.tr,
                            maxLine: 1,
                            validator:
                                context.read<AddMemberCubit>().validatorName,
                            textInputAction: TextInputAction.done),
                        SizedBox(height: 10.0),
                        DropdownGender(),
                        SizedBox(height: 10.0),
                        _customTextFieldAutoComplete(
                            controller: _textControllerJob,
                            hintText: 'job'.tr,
                            textInputAction: TextInputAction.next,
                            getList: Suggestions.getSuggestionsJob,
                            validator: null),
                        SizedBox(height: 10.0),
                        _customTextFieldAutoComplete(
                            controller: _textControllerRelationsShip,
                            hintText: 'relations_ship'.tr,
                            textInputAction: TextInputAction.next,
                            getList: Suggestions.getSuggestionsRelasionShip,
                            validator: context
                                .read<AddMemberCubit>()
                                .validatorRelationShip),
                        SizedBox(height: 10.0),
                        _customTextFieldAutoComplete(
                            controller: _textControllerEducation,
                            hintText: 'education'.tr,
                            textInputAction: TextInputAction.next,
                            getList: Suggestions.getSuggestionsEducations,
                            validator: null),
                        SizedBox(height: 10.0),
                        _customTextField(
                            controller: _controllerDes,
                            hintText: 'description_member'.tr,
                            validator: null,
                            textInputAction: TextInputAction.done),
                        SizedBox(height: 10.0),
                        _customTextField(
                            enable: true,
                            onTap: () => context
                                .read<AddMemberCubit>()
                                .pickTime(context, _textControllerBirthDay,
                                    _textControllerBirthDayFormat),
                            maxLine: 1,
                            validator: null,
                            hintText: 'date_of_birth'.tr,
                            controller: _textControllerBirthDay),
                        SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextFieldAutoComplete(
      {TextEditingController controller,
      String hintText,
      Function validator,
      TextInputAction textInputAction,
      Function getList}) {
    return TypeAheadFormField(
      direction: AxisDirection.up,
      textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          autocorrect: false,
          autofocus: false,
          textInputAction: textInputAction,
          enableSuggestions: false,
          decoration: customInputDecoration(hintText)),
      suggestionsCallback: (pattern) {
        if (pattern.isEmpty) {
          return null;
        }

        return getList(pattern);
      },
      hideOnLoading: true,
      animationDuration: Duration(milliseconds: 300),
      loadingBuilder: (context) => null,
      hideOnEmpty: true,
      itemBuilder: (context, value) {
        return ListTile(
          title: Text(value.toString().tr),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.text = suggestion.toString().tr;
      },
      validator: validator,
    );
  }

  Widget _iconEdit({Function onPress, BuildContext context}) {
    return Center(
      child: SizedBox(
        height: height,
        width: width - 10.0,
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () => context.read<AddMemberCubit>().pickFile(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: whiteColor, width: 1),
                  color: greyColor300),
              child: Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField(
      {TextEditingController controller,
      String hintText,
      TextInputAction textInputAction,
      Function validator,
      bool enable = false,
      TextAlign textAlign = TextAlign.start,
      int maxLine,
      Function onTap}) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign,
      textInputAction: textInputAction,
      autocorrect: false,
      autofocus: false,
      validator: validator,
      readOnly: enable,
      onTap: onTap,
      maxLines: maxLine,
      decoration: customInputDecoration(hintText),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final titleAppbar = context.watch<AddMemberCubit>().handleTitleAppbar();
    return AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.check, color: appIconColor),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<AddMemberCubit>().handleButton(
                      name: _controllerName.text,
                      des: _controllerDes.text,
                      birthDay: _textControllerBirthDayFormat.text,
                      job: _textControllerJob.text,
                      education: _textControllerEducation.text,
                      relation: _textControllerRelationsShip.text);
                }
              })
        ],
        elevation: 1.0,
        title: Text(titleAppbar, style: headingBlack18));
  }

  @override
  void dispose(BuildContext context) {
    _controllerName.dispose();
    _controllerDes.dispose();
    _textControllerBirthDay.dispose();
    _textControllerRelationsShip.dispose();
    _textControllerJob.dispose();
    _textControllerEducation.dispose();
    _textControllerBirthDayFormat.dispose();
    super.dispose(context);
  }
}
