import 'dart:io';

import 'package:dio/dio.dart';
import 'package:farmgate/src/common/config.dart';
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
import 'package:farmgate/src/model/share/share_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("api/v1/login-update")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @GET('api/v1/posts/videos')
  Future<VideoResponse> getListVideo();

  @GET('api/v1/categories/filters')
  Future<CategoryResponse> getListCategory();

  @GET('api/v1/posts/hot-news')
  Future<HotResponse> getListHot();

  @GET('api/v1/posts/categories/{slug_categories}')
  Future<NewsCategoryResponse> getNewCategoryResponse(
      @Path('slug_categories') String slugCategories, @Query('page') int page);

  @GET('api/v1/posts/filters')
  Future<NewsCategoryResponse> getHomeNews(@Query('page') int page);

  @GET('api/v1/tags')
  Future<TagsResponse> getTags();

  @GET('api/v1/tags/{slug_tags}')
  Future<NewsByTagsResponse> getNewByTag(
      @Path('slug_tags') String slugCategories);

  @GET('api/v1/posts/share-experiences')
  Future<ShareResponse> getShareExperiences();

  @GET('api/v1/posts/{slug_post}')
  Future<DetailNewsResponse> getPost(@Path('slug_post') String slugPost);

  @GET('api/v1/me')
  Future<ProfileResponse> getProfile();

  @POST('api/v1/posts/create')
  Future<PostResponse> postNews(
      {@Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'content') String content,
      @Part(name: 'categories[0]') String categoryId,
      @Part(name: 'language') String language,
      @Part(name: 'latitude') String lat,
      @Part(name: 'longitude') String long,
      @Part(name: 'image_input') File picture});

  @POST('api/v1/update-avatar')
  Future<AvatarResponse> uploadAvatar({@Part(name: 'avatar') File picture});

  @POST('api/v1/register-update')
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @GET('api/v1/logout')
  Future<void> logout();

  @GET('api/v1/get-comment-facebook/{slug_post}')
  Future<PostCommentResponse> getCommentFacbook(
      @Path('slug_post') String slugPost);

  @PUT('api/v1/me')
  Future<ProfileUpdateResponse> updateProfile(
      @Body() ProfileRequest profileRequest);

  @PUT('api/v1/change-password')
  @FormUrlEncoded()
  Future<ChangePasswordResponse> changePassword(
      @Field('password') String password);

  @POST('api/v1/password/forgot-update')
  Future<ForgotPasswordResponse> forgotPassword(
      @Body() ForgotPasswordRequest forgotPasswordRequest);

  @POST('api/v1/contact/send')
  Future<ContactResponse> contact(@Body() ContactRequest request);

  @GET('api/v1/rules')
  Future<InformationResponse> getInformation();

  @GET('api/v1/my-report')
  Future<MyReportResponse> getMyReport();

  @GET('api/v1/my-garden')
  Future<GardenResponse> getMyGraden();

  @GET('api/v1/garden/{graden_id}')
  Future<GardenDetailResponse> getGardenDetailResponse(
      @Path('graden_id') int id);

  @GET('api/v1/tree-types')
  Future<TreeTypeResponse> getTreeTypes();

  @GET('api/v1/tree/{tree_id}')
  Future<TreeResponse> getListTree(@Path('tree_id') int id);

  @POST('api/v1/add-tree-garden/{garden_id}')
  Future<BaseResponse> addTreeGarden(
    @Path('garden_id') int gardenId,
    @Part(name: 'tree_id') int id,
  );

  @POST('api/v1/add-garden')
  @MultiPart()
  Future<AddGradenResponse> addGarden(
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'address') String address,
      @Part(name: 'location_polygon') String location,
      @Part(name: 'image[]') List<File> pictures);

  @POST('api/v1/edit-garden/{garden_id}')
  @MultiPart()
  Future<AddGradenResponse> editGarden(
      @Path('garden_id') int gardenId,
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'address') String address,
      @Part(name: 'location_polygon') String location,
      @Part(name: 'image[]') List<File> pictures);

  @POST('api/v1/add-member-garden/{id}')
  @MultiPart()
  Future<AddMemberResponse> addMember(
      @Path('id') int id,
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      {@Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job,
      @Part(name: 'image') File picture});

  @POST('api/v1/add-member-garden/{id}')
  @MultiPart()
  Future<AddMemberResponse> addMemberNoImage(
      @Path('id') int id,
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      {@Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job});

  @POST('api/v1/edit-member-garden/{id}')
  Future<EditMemberResponse> editMember(
      @Path('id') int id,
      @Part(name: 'members_garden_id') int gardenId,
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      {@Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job,
      @Part(name: 'image') File picture});

  @POST('api/v1/edit-member-garden/{id}')
  Future<EditMemberResponse> editMemberNoImage(
    @Path('id') int id,
    @Part(name: 'members_garden_id') int gardenId,
    @Part(name: 'name') String name,
    @Part(name: 'description') String description,
    @Part(name: 'relation') String relation,
    @Part(name: 'education') String education,
    @Part(name: 'sex') String sex,
    @Part(name: 'dob') String dob,
    @Part(name: 'job') String job,
  );

  @POST('api/v1/add-people-garden')
  Future<AddMemberResponse> addPeople(
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      {@Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job,
      @Part(name: 'image') File picture});

  @POST('api/v1/add-people-garden')
  Future<AddMemberResponse> addPeopleNoImage(
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      @Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job);

  @POST('api/v1/edit-people-garden/{id}')
  Future<EditMemberResponse> editPeople(
      @Path('id') int id,
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      {@Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job,
      @Part(name: 'image') File picture});

  @POST('api/v1/edit-people-garden/{id}')
  Future<EditMemberResponse> editPeopleNoImage(
      @Path('id') int id,
      @Part(name: 'name') String name,
      @Part(name: 'description') String description,
      @Part(name: 'relation') String relation,
      @Part(name: 'education') String education,
      @Part(name: 'sex') String sex,
      @Part(name: 'dob') String dob,
      @Part(name: 'job') String job);

  @POST('api/v1/garden-plant-protection-products/{id}')
  Future<BaseResponse> addPlantProtection(@Path('id') int gardenId,
      @Body() ActionProtectRequest actionProtectRequest);

  @POST('api/v1/delete-member-garden/{id}')
  Future<DeleteMemberResponse> deleteMember(
      @Field('members_garden_id') int idMember, @Path('id') int id);

  @POST('api/v1/add-people-garden-to-member-garden/{id}')
  Future<BaseResponse> addPeopleToGraden(
      @Field('people_garden_id') int peopleGardenId, @Path('id') int id);

  @POST('api/v1/delete-people-garden/{id}')
  Future<DeleteMemberResponse> deletePeople(@Path('id') int id);

  @POST('api/v1/delete-garden/{id}')
  Future<BaseResponse> delete(@Path('id') int id);

  @GET("api/v1/plant-protection-products-type/detail/{id}")
  Future<PlantResponse> getPlantProtect(@Path('id') int id);

  @GET('api/v1/get-history-action/{garden_id}')
  Future<GardenHistoryActionResponse> gardenHistoryAction(
      @Path('garden_id') int gardenId, @Query('page') int page);

  @POST('api/v1/update-fcm')
  Future<FcmResponse> pushFCMToken(@Body() FcmRequest data);

  @GET("api/v1/plant-protection-products-type")
  Future<PlantProtectionTypesResponse> getPlantProtectType();

  @GET("api/v1/get-types-action")
  Future<ActionGardenResponse> getListActionGarden();

  @GET("api/v1/get-list-types-action/{id}")
  Future<ActionResponse> getListActionById(@Path('id') int id);

  @POST('api/v1/add-action-garden/{id}')
  Future<BaseResponse> addActionGarden(
      @Path('id') int gardenId, @Body() ActionRequest actionRequest);

  @GET("api/v1//get-city")
  Future<CityResponse> getCity();

  @GET("api/v1/get-district/{id}")
  Future<DistrictResponse> getDistrictInCity(@Path('id') String id);

  @GET("api/v1/get-ward/{id}")
  Future<WardResponse> getWardInDistrict(@Path('id') String id);

  @GET("api/v1/get-people-garden")
  Future<PeopleResponse> getAllPeople();

  @GET("api/v1/my-project")
  Future<MyProjectResponse> getMyProjectResponse();

  @POST('api/v1/change-user-type')
  @MultiPart()
  Future<BaseResponse> updateUser(
      @Part(name: 'permission') int permission,
      @Part(name: 'number_id') String numberId,
      @Part(name: 'business_id') String businessId,
      {@Part(name: 'image_number_id_before') File imageIDBefore,
      @Part(name: 'image_number_id_after') File imageIDAfter,
      @Part(name: 'image_business_license') File imageBusiness});

  @POST('api/v1/change-user-type')
  @MultiPart()
  Future<BaseResponse> updateUserNoBusiness(
    @Part(name: 'permission') int permission,
    @Part(name: 'number_id') String numberId, {
    @Part(name: 'image_number_id_before') File imageIDBefore,
    @Part(name: 'image_number_id_after') File imageIDAfter,
  });

  @GET('api/v1/get-all-project')
  Future<AllProjectResponse> getAllProject();

  @GET('api/v1/get-member-partner-project/{id}')
  Future<MemberPartnerProjectResponse> getMemberPartnerProject(
      @Path('id') String id);

  @POST('api/v1/join-project/{id}')
  Future<BaseResponse> joinProject(
      @Path('id') int id, @Body() RequestJoinProject requestjoin);

  @POST('api/v1/add-transaction-user/{id}')
  Future<BaseResponse> addOrder(
      @Path('id') int id,
      @Part(name: 'date_sale') String dateSale,
      @Part(name: 'number_contract') String numberContact,
      @Part(name: 'amount_sale') String amountSale,
      @Part(name: 'price') String unitPrice,
      @Part(name: 'number_move') String numberMove,
      @Part(name: 'bonus_4c') String unit4c,
      @Part(name: 'type_goods') String typeGoods,
      @Part(name: 'type_sale') String typeSale,
      @Part(name: 'member_id_buy') String memberID,
      @Part(name: 'total_bonus_4c') String sum4c,
      @Part(name: 'total_money') String sum);

  @GET('api/v1/get-transaction-user/{id}')
  Future<HistoryTransactionProject> getHistoryTransactionProject(
      @Path('id') String id);

  @POST('api/v1/user-sale-cancel/{id}')
  Future<BaseResponse> userSaleCancel(
      @Path('id') int id, @Part(name: 'reason') String reason);

  @POST('api/v1/user-buy-cancel/{id}')
  Future<BaseResponse> userBuyCancel(
      @Path('id') int id, @Part(name: 'reason') String reason);

  @POST('api/v1/user-buy-confirm/{id}')
  Future<BaseResponse> userBuyConfirm(
      @Path('id') int id, @Part(name: 'reason') String reason);

  @GET('api/v1/get-transaction/{id}')
  Future<HistoryTransactionDetalResponse> getHistoryTransactionDetail(
      @Path('id') String id);
}
