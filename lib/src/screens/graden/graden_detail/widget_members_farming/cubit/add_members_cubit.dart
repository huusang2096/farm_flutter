import 'dart:io';

import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/base_cubit.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/status_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simplest/simplest.dart';

part 'add_members_cubit.freezed.dart';
part 'add_members_state.dart';

class AddMemberCubit extends BaseCubit<AddMembersState> {
  AddMemberCubit(Member member, String status, int idGarden)
      : super(Initial(DataAddMember(
            member: member,
            status: status,
            idGarden: idGarden,
            selectedGender: member?.sex)));

  void handleButton(
      {String name,
      String des,
      String birthDay,
      String job,
      String education,
      String relation}) {
    final statusCheck = state.data.status;
    if (statusCheck == StatusAddMember.ADD_MEMBER ||
        statusCheck == StatusAddMember.ADD_PEOPLE) {
      addMemberOrPeople(
          name: name,
          des: des,
          birthDay: birthDay,
          job: job,
          education: education,
          relation: relation);
    }

    if (statusCheck == StatusAddMember.EDIT_MEMBER ||
        statusCheck == StatusAddMember.EDIT_PEOPLE) {
      editMemberOrPeople(
          name: name,
          des: des,
          birthDay: birthDay,
          job: job,
          education: education,
          relation: relation);
    }
  }

  void editMemberOrPeople(
      {String name,
      String des,
      String birthDay,
      String job,
      String education,
      String relation}) async {
    final statusCheck = state.data.status;
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      if (statusCheck == StatusAddMember.EDIT_MEMBER) {
        final response = await dataRepository.editMember(
            state.data?.idGarden, state.data?.member?.id, name, des, relation,
            education: education,
            sex: state.data?.selectedGender,
            dob: birthDay,
            job: job,
            picture: state.data?.imgTemp);
        emit(Loading(state.data.copyWith(isLoading: false)));
        if (!response.error) {
          snackbarService.showSnackbar(message: 'update_successful'.tr);
          emit(Success(state.data.copyWith(member: response.data)));
        } else {
          snackbarService.showSnackbar(message: 'update_failed'.tr);
        }
      }
      if (statusCheck == StatusAddMember.EDIT_PEOPLE) {
        final response = await dataRepository.editPeople(
            state.data?.member?.id, name, des, relation,
            education: education,
            sex: state.data?.selectedGender,
            dob: birthDay,
            job: job,
            picture: state.data?.imgTemp);
        emit(Loading(state.data.copyWith(isLoading: false)));
        if (!response.error) {
          snackbarService.showSnackbar(message: 'update_successful'.tr);
          emit(Success(state.data.copyWith(member: response.data)));
        } else {
          snackbarService.showSnackbar(message: 'update_failed'.tr);
        }
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }

  void addMemberOrPeople(
      {String name,
      String des,
      String birthDay,
      String job,
      String education,
      String relation}) async {
    final statusCheck = state.data.status;
    if (des.isEmpty || des == null) {
      des = 'information'.tr;
    }
    try {
      emit(Loading(state.data.copyWith(isLoading: true)));
      final List<Member> listTemp = [];
      if (statusCheck == StatusAddMember.ADD_MEMBER) {
        final response = await dataRepository.addMember(
            state.data.idGarden, name, des, relation,
            education: education,
            sex: state.data?.selectedGender,
            dob: birthDay,
            job: job,
            picture: state.data?.imgTemp);
        emit(Loading(state.data.copyWith(isLoading: false)));

        if (!response.error) {
          snackbarService.showSnackbar(message: 'add_members_success'.tr);
          listTemp
            ..addAll(state.data.listMemberAddNew)
            ..add(response.data);
          emit(AddSuccess(state.data.copyWith(listMemberAddNew: listTemp)));
        } else {
          snackbarService.showSnackbar(message: 'add_member_failed'.tr);
        }
      }
      if (statusCheck == StatusAddMember.ADD_PEOPLE) {
        final response = await dataRepository.addPeople(name, des, relation,
            education: education,
            sex: state.data?.selectedGender,
            dob: birthDay,
            job: job,
            picture: state.data?.imgTemp);
        emit(Loading(state.data.copyWith(isLoading: false)));
        if (!response.error) {
          snackbarService.showSnackbar(message: 'add_people_success'.tr);
          listTemp
            ..addAll(state.data.listMemberAddNew)
            ..add(response.data);
          emit(AddSuccess(state.data.copyWith(listMemberAddNew: listTemp)));
        } else {
          snackbarService.showSnackbar(message: 'add_people_failed'.tr);
        }
      }
    } catch (e) {
      emit(Loading(state.data.copyWith(isLoading: false)));
      handleAppError(e);
    }
  }

  void pickFile() async {
    File file = await locator<MediaService>().pickImage();
    File compressedFile = file;
    if (file != null) {
      compressedFile =
          await FlutterNativeImage.compressImage(file.path, quality: 50);
    }
    if (file != null) {
      emit(Loaded(state.data.copyWith(imgTemp: compressedFile)));
    }
  }

  String handleTitleAppbar() {
    final status = state.data.status;
    if (status == StatusAddMember.ADD_MEMBER) {
      return 'add_members'.tr;
    }
    return 'edit_profile'.tr;
  }

  String handleTitleButton() {
    final status = state.data.status;
    if (status == StatusAddMember.ADD_MEMBER) {
      return 'add'.tr;
    }
    return 'update_user'.tr;
  }

  String validatorName(String value) {
    if (value.isEmpty) {
      return 'name_is_required'.tr;
    }
    if (value.length > 255) {
      return 'not_larger_than_characters'.tr;
    }
    return null;
  }

  String validatorBirthDay(String value) {
    if (value == null || value.isEmpty) {
      return 'please_select_a_date_of_birth'.tr;
    }

    return null;
  }

  String validatorRelationShip(String value) {
    if (value == null || value.isEmpty) {
      return 'please_define_a_relationship'.tr;
    }

    return null;
  }

  String validatorDes(String value) {
    if (value.isEmpty) {
      return 'content_is_required'.tr;
    }
    if (value.length > 255) {
      return 'not_larger_than_characters'.tr;
    }

    return null;
  }

  String validatorJob(String value) {
    if (value.isEmpty) {
      return 'please_define_career'.tr;
    }

    return null;
  }

  String validatorEducation(String value) {
    if (value.isEmpty) {
      return 'please_determine_your_education'.tr;
    }

    return null;
  }

  Future<bool> handlePop() async {
    if (state.data.status == StatusAddMember.ADD_MEMBER) {
      navigator.pop({'listData': state.data.listMemberAddNew});
    } else {
      navigator.pop({'data': state.data?.member});
    }

    return true;
  }

  void pickTime(
      BuildContext context,
      TextEditingController _textControllerBirthDay,
      TextEditingController _textControllerBirthDayFormat) async {
    final dateMap =
        await showDatesPicker(context, initialBirthDay: state.data?.member?.dob)
            as Map;
    if (dateMap != null) {
      final dateTime = dateMap['date'];
      _textControllerBirthDay.text = formatDate(dateTime);
      _textControllerBirthDayFormat.text =
          DateFormat('yyyy-MM-dd').format(dateTime);
      emit(Loaded(state.data.copyWith()));
    }
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/y').format(dateTime);
  }

  void selectedGender(String value) {
    emit(Loaded(state.data.copyWith(selectedGender: value)));
  }

  void clearImage() {
    emit(Loaded(state.data.copyWith(imgTemp: null, selectedGender: null)));
  }
}
