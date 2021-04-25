import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/storage/app_prefs.dart';
import 'package:farmgate/src/model/add_members/add_member_response.dart';
import 'package:farmgate/src/model/add_members/delete_member_response.dart';
import 'package:farmgate/src/model/add_members/edit_member_response.dart';
import 'package:farmgate/src/model/base_response.dart';
import 'package:farmgate/src/model/change_password/change_password_response.dart';
import 'package:farmgate/src/model/contact/contact_request.dart';
import 'package:farmgate/src/model/contact/contact_response.dart';
import 'package:farmgate/src/model/detail/commnet_post_response.dart';
import 'package:farmgate/src/model/detail/detail_news_response.dart';
import 'package:farmgate/src/model/forgot_password/forgot_password_request.dart';
import 'package:farmgate/src/model/forgot_password/forgot_password_response.dart';
import 'package:farmgate/src/model/graden/action.dart';
import 'package:farmgate/src/model/graden/action_garden.dart';
import 'package:farmgate/src/model/graden/action_protect_request.dart';
import 'package:farmgate/src/model/graden/action_request.dart';
import 'package:farmgate/src/model/graden/add_garden_response.dart';
import 'package:farmgate/src/model/graden/garden_history_action_response.dart';
import 'package:farmgate/src/model/graden/graden_detail_response.dart';
import 'package:farmgate/src/model/graden/graden_response.dart';
import 'package:farmgate/src/model/graden/pepole_response.dart';
import 'package:farmgate/src/model/graden/tree_response.dart';
import 'package:farmgate/src/model/graden/tree_type_response.dart';
import 'package:farmgate/src/model/information/information.dart';
import 'package:farmgate/src/model/login/avatar_response.dart';
import 'package:farmgate/src/model/login/login_request.dart';
import 'package:farmgate/src/model/login/login_response.dart';
import 'package:farmgate/src/model/manager_project/all_project_response.dart';
import 'package:farmgate/src/model/manager_project/history_detail_response.dart';
import 'package:farmgate/src/model/manager_project/history_project.dart';
import 'package:farmgate/src/model/manager_project/mem_partner_project_response.dart';
import 'package:farmgate/src/model/manager_project/my_project_response.dart';
import 'package:farmgate/src/model/manager_project/request_join_project.dart';
import 'package:farmgate/src/model/news/category_response.dart';
import 'package:farmgate/src/model/news/hot_response.dart';
import 'package:farmgate/src/model/news/news_category_response.dart';
import 'package:farmgate/src/model/news/video_response.dart';
import 'package:farmgate/src/model/notification/fcm_request.dart';
import 'package:farmgate/src/model/notification/fcm_response.dart';
import 'package:farmgate/src/model/pick_address/city_response.dart';
import 'package:farmgate/src/model/pick_address/district_response.dart';
import 'package:farmgate/src/model/pick_address/ward_response.dart';
import 'package:farmgate/src/model/plant_protect/plant_protection_types_response.dart';
import 'package:farmgate/src/model/plant_protect/plant_respone.dart';
import 'package:farmgate/src/model/post/post_response.dart';
import 'package:farmgate/src/model/profile/profile_request.dart';
import 'package:farmgate/src/model/profile/profile_response.dart';
import 'package:farmgate/src/model/profile/profile_update_response.dart';
import 'package:farmgate/src/model/register/register_request_model.dart';
import 'package:farmgate/src/model/register/register_response.dart';
import 'package:farmgate/src/model/report/my_report.dart';
import 'package:farmgate/src/model/search/news_category_response.dart';
import 'package:farmgate/src/model/search/tag_response.dart';
import 'package:farmgate/src/model/search_place_by_latlng_response.dart';
import 'package:farmgate/src/model/search_place_request.dart';
import 'package:farmgate/src/model/search_place_response.dart';
import 'package:farmgate/src/model/share/share_response.dart';
import 'package:farmgate/src/network/google_client.dart';
import 'package:farmgate/src/network/rest_client.dart';
import 'package:simplest/simplest.dart';

@lazySingleton
class DataRepository implements RestClient {
  final dio = Dio();
  RestClient _client;
  GoogleClient _googleClient;

  DataRepository() {
    dio.interceptors
        .add(LogInterceptor(requestBody: false, responseBody: false));
    _client = RestClient(dio);
    loadAuthHeader();
    _googleClient = GoogleClient(dio);
  }

  void loadAuthHeader() async {
    final _appPref = locator<AppPref>();
    dio.options.headers["Authorization"] = "Bearer " + _appPref.token;
    dio.options.headers["Accept"] = "application/json";
    // dio.options.headers["Content-Type"] = "application/json";
    log('access token ${_appPref.token}');
  }

  Future<SearchPlaceResponse> searchPlace(
      {String key, language, region, query}) async {
    return _googleClient.searchPlace(key, language, region, query);
  }

  Future<SearchPlaceByLatLngResponse> searchPlaceByLatLng(
      SearchPlaceRequest searchPlaceRequest) {
    return _googleClient.searchPlaceByLatLng(request: searchPlaceRequest);
  }

  @override
  Future<VideoResponse> getListVideo() {
    return _client.getListVideo();
  }

  @override
  Future<CategoryResponse> getListCategory() {
    return _client.getListCategory();
  }

  @override
  Future<HotResponse> getListHot() {
    return _client.getListHot();
  }

  @override
  Future<NewsCategoryResponse> getNewCategoryResponse(
      String slugCategories, int page) {
    return _client.getNewCategoryResponse(slugCategories, page);
  }

  @override
  Future<NewsCategoryResponse> getHomeNews(int page) {
    return _client.getHomeNews(page);
  }

  @override
  Future<TagsResponse> getTags() {
    return _client.getTags();
  }

  @override
  Future<NewsByTagsResponse> getNewByTag(String slug) {
    return _client.getNewByTag(slug);
  }

  @override
  Future<ShareResponse> getShareExperiences() {
    return _client.getShareExperiences();
  }

  @override
  Future<DetailNewsResponse> getPost(String slugPost) {
    return _client.getPost(slugPost);
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return _client.login(loginRequest);
  }

  @override
  Future<ProfileResponse> getProfile() {
    return _client.getProfile();
  }

  @override
  Future<PostResponse> postNews(
      {String name,
      String description,
      String content,
      String categoryId,
      String language,
      String lat,
      String long,
      File picture,
      String source}) {
    return _client.postNews(
        name: name,
        description: description,
        content: content,
        categoryId: categoryId,
        language: language,
        lat: lat,
        long: long,
        picture: picture,
        source: source);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) {
    return _client.register(request);
  }

  @override
  Future<void> logout() {
    return _client.logout();
  }

  @override
  Future<PostCommentResponse> getCommentFacbook(String slugPost) {
    return _client.getCommentFacbook(slugPost);
  }

  @override
  Future<AvatarResponse> uploadAvatar({File picture}) {
    return _client.uploadAvatar(picture: picture);
  }

  @override
  Future<ProfileUpdateResponse> updateProfile(ProfileRequest profileRequest) {
    return _client.updateProfile(profileRequest);
  }

  @override
  Future<ChangePasswordResponse> changePassword(String password) {
    return _client.changePassword(password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) {
    return _client.forgotPassword(forgotPasswordRequest);
  }

  @override
  Future<ContactResponse> contact(ContactRequest request) {
    return _client.contact(request);
  }

  Future<InformationResponse> getInformation() {
    return _client.getInformation();
  }

  @override
  Future<MyReportResponse> getMyReport() {
    return _client.getMyReport();
  }

  @override
  Future<GardenResponse> getMyGraden() {
    return _client.getMyGraden();
  }

  @override
  Future<GardenDetailResponse> getGardenDetailResponse(int id) {
    return _client.getGardenDetailResponse(id);
  }

  @override
  Future<TreeResponse> getListTree(int id) {
    return _client.getListTree(id);
  }

  @override
  Future<TreeTypeResponse> getTreeTypes() {
    return _client.getTreeTypes();
  }

  @override
  Future<DeleteMemberResponse> deleteMember(int idMember, int idGarden) {
    return _client.deleteMember(idMember, idGarden);
  }

  @override
  Future<DeleteMemberResponse> deletePeople(int idPeople) {
    return _client.deletePeople(idPeople);
  }

  @override
  Future<PlantResponse> getPlantProtect(int id) {
    return _client.getPlantProtect(id);
  }

  @override
  Future<BaseResponse> delete(int id) {
    return _client.delete(id);
  }

  Future<GardenHistoryActionResponse> gardenHistoryAction(
      int gardenId, int page) {
    return _client.gardenHistoryAction(gardenId, page);
  }

  @override
  Future<AddMemberResponse> addMember(
      int id, String name, String description, String relation,
      {String education, String sex, String dob, String job, File picture}) {
    return _client.addMember(id, name, description, relation,
        education: education, sex: sex, dob: dob, job: job, picture: picture);
  }

  @override
  Future<AddMemberResponse> addPeople(
      String name, String description, String relation,
      {String education, String sex, String dob, String job, File picture}) {
    return _client.addPeople(name, description, relation,
        education: education, sex: sex, dob: dob, job: job, picture: picture);
  }

  @override
  Future<EditMemberResponse> editMember(
      int id, int gardenId, String name, String description, String relation,
      {String education, String sex, String dob, String job, File picture}) {
    return _client.editMember(id, gardenId, name, description, relation,
        education: education, sex: sex, dob: dob, job: job, picture: picture);
  }

  @override
  Future<EditMemberResponse> editPeople(
      int id, String name, String description, String relation,
      {String education, String sex, String dob, String job, File picture}) {
    return _client.editPeople(id, name, description, relation,
        education: education, sex: sex, dob: dob, job: job, picture: picture);
  }

  @override
  Future<EditMemberResponse> editMemberNoImage(
      int id,
      int gardenId,
      String name,
      String description,
      String relation,
      String education,
      String sex,
      String dob,
      String job) {
    return _client.editMemberNoImage(
        id, gardenId, name, description, relation, education, sex, dob, job);
  }

  @override
  Future<EditMemberResponse> editPeopleNoImage(
      int id,
      String name,
      String description,
      String relation,
      String education,
      String sex,
      String dob,
      String job) {
    return _client.editPeopleNoImage(
      id,
      name,
      description,
      relation,
      education,
      sex,
      dob,
      job,
    );
  }

  @override
  Future<AddGradenResponse> addGarden(String name, String description,
      String address, String location, List<File> pictures) {
    return _client.addGarden(name, description, address, location, pictures);
  }

  @override
  Future<BaseResponse> addPlantProtection(
      int gardenId, ActionProtectRequest actionProtectRequest) {
    return _client.addPlantProtection(gardenId, actionProtectRequest);
  }

  @override
  Future<AddGradenResponse> editGarden(
      int gardenId,
      String name,
      String description,
      String address,
      String location,
      List<File> pictures) {
    return _client.editGarden(
        gardenId, name, description, address, location, pictures);
  }

  @override
  Future<FcmResponse> pushFCMToken(FcmRequest data) {
    return _client.pushFCMToken(data);
  }

  @override
  Future<PlantProtectionTypesResponse> getPlantProtectType() {
    return _client.getPlantProtectType();
  }

  @override
  Future<ActionResponse> getListActionById(int id) {
    return _client.getListActionById(id);
  }

  @override
  Future<ActionGardenResponse> getListActionGarden() {
    return _client.getListActionGarden();
  }

  @override
  Future<BaseResponse> addActionGarden(
      int gardenId, ActionRequest actionRequest) {
    return _client.addActionGarden(gardenId, actionRequest);
  }

  @override
  Future<WardResponse> getWardInDistrict(String id) {
    return _client.getWardInDistrict(id);
  }

  @override
  Future<CityResponse> getCity() {
    return _client.getCity();
  }

  @override
  Future<DistrictResponse> getDistrictInCity(String id) {
    return _client.getDistrictInCity(id);
  }

  @override
  Future<PeopleResponse> getAllPeople() {
    return _client.getAllPeople();
  }

  @override
  Future<BaseResponse> addPeopleToGraden(int peopleGardenId, int id) {
    return _client.addPeopleToGraden(peopleGardenId, id);
  }

  @override
  Future<AddMemberResponse> addMemberNoImage(
      int id, String name, String description, String relation,
      {String education, String sex, String dob, String job}) {
    return _client.addMemberNoImage(id, name, description, relation,
        education: education, sex: sex, dob: dob, job: job);
  }

  @override
  Future<AddMemberResponse> addPeopleNoImage(String name, String description,
      String relation, String education, String sex, String dob, String job) {
    return _client.addPeopleNoImage(
        name, description, relation, education, sex, dob, job);
  }

  @override
  Future<BaseResponse> updateUser(
      int permission, String numberId, String businessId,
      {File imageIDBefore, File imageIDAfter, File imageBusiness}) {
    return _client.updateUser(permission, numberId, businessId,
        imageIDBefore: imageIDBefore,
        imageIDAfter: imageIDAfter,
        imageBusiness: imageBusiness);
  }

  @override
  Future<BaseResponse> updateUserNoBusiness(int permission, String numberId,
      {File imageIDBefore, File imageIDAfter}) {
    return _client.updateUserNoBusiness(permission, numberId,
        imageIDBefore: imageIDBefore, imageIDAfter: imageIDAfter);
  }

  @override
  Future<MyProjectResponse> getMyProjectResponse() {
    return _client.getMyProjectResponse();
  }

  Future<AllProjectResponse> getAllProject() {
    return _client.getAllProject();
  }

  @override
  Future<BaseResponse> joinProject(int id, RequestJoinProject requestjoin) {
    return _client.joinProject(id, requestjoin);
  }

  @override
  Future<MemberPartnerProjectResponse> getMemberPartnerProject(String id) {
    return _client.getMemberPartnerProject(id);
  }

  @override
  Future<BaseResponse> addOrder(
      int id,
      String dateSale,
      String numberContact,
      String amountSale,
      String unitPrice,
      String numberMove,
      String unit4c,
      String typeGoods,
      String typeSale,
      String memberID,
      String sum4c,
      String sum) {
    return _client.addOrder(id, dateSale, numberContact, amountSale, unitPrice,
        numberMove, unit4c, typeGoods, typeSale, memberID, sum4c, sum);
  }

  @override
  Future<HistoryTransactionProject> getHistoryTransactionProject(String id) {
    return _client.getHistoryTransactionProject(id);
  }

  @override
  Future<BaseResponse> userBuyCancel(int id, String reason) {
    return _client.userBuyCancel(id, reason);
  }

  @override
  Future<BaseResponse> userBuyConfirm(int id, String reason) {
    return _client.userBuyConfirm(id, reason);
  }

  @override
  Future<BaseResponse> userSaleCancel(int id, String reason) {
    return _client.userSaleCancel(id, reason);
  }

  @override
  Future<HistoryTransactionDetalResponse> getHistoryTransactionDetail(
      String id) {
    return _client.getHistoryTransactionDetail(id);
  }

  @override
  Future<BaseResponse> addTreeGarden(
      int gardenId,
      int id,
      String seeding,
      String amount,
      int year,
      String plantingMethod,
      String area,
      String statusGarden,
      String owner) {
    // TODO: implement addTreeGarden
    return _client.addTreeGarden(gardenId, id, seeding, amount, year,
        plantingMethod, area, statusGarden, owner);
  }
}
