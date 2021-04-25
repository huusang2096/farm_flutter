import 'package:farmgate/src/screens/addNew/add_news.dart';
import 'package:farmgate/src/screens/change_password/change_password_screen.dart';
import 'package:farmgate/src/screens/contact/contact_screen.dart';
import 'package:farmgate/src/screens/forgot_password/forgot_password_phone_screen.dart';
import 'package:farmgate/src/screens/forgot_password/forgot_password_screen.dart';
import 'package:farmgate/src/screens/graden/addGarden/add_garden.dart';
import 'package:farmgate/src/screens/graden/addGarden/edit_garden.dart';
import 'package:farmgate/src/screens/graden/graden.dart';
import 'package:farmgate/src/screens/graden/graden_detail/detail_garden_screen.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget/tree_show_all_screen.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_action/widget/input/tree_show_all_and_pick_tree_screen.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_history_action/show_all_history_screen.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_members_farming/screen/add_members_screen.dart';
import 'package:farmgate/src/screens/graden/graden_detail/widget_pepole_farming/people_screen.dart';
import 'package:farmgate/src/screens/graden/plantprotect/protect_product_types.dart';
import 'package:farmgate/src/screens/graden/tree/trees.dart';
import 'package:farmgate/src/screens/help/help_screen.dart';
import 'package:farmgate/src/screens/home/home_screen.dart';
import 'package:farmgate/src/screens/infomation_app/infomation_app_screen.dart';
import 'package:farmgate/src/screens/languages/languages_screen.dart';
import 'package:farmgate/src/screens/location/garden_boder_screen.dart';
import 'package:farmgate/src/screens/location/search_place_screen.dart';
import 'package:farmgate/src/screens/location/user_place_screen.dart';
import 'package:farmgate/src/screens/login/login_screen.dart';
import 'package:farmgate/src/screens/login/login_with_phone_screen.dart';
import 'package:farmgate/src/screens/manager_project/all_project/all_project_screen.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/confirm_transaction/confirm_transaction_screen.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/manager_project_detail_screen.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_detail/transaction/transaction_4c_screen.dart';
import 'package:farmgate/src/screens/manager_project/manager_project_screen.dart';
import 'package:farmgate/src/screens/myqrcode/my_qr_code_screen.dart';
import 'package:farmgate/src/screens/newsDetail/comment_screen.dart';
import 'package:farmgate/src/screens/newsDetail/new_detail_screen.dart';
import 'package:farmgate/src/screens/newsDetail/video_detail.dart';
import 'package:farmgate/src/screens/newsDetail/widget/web_support.dart';
import 'package:farmgate/src/screens/pickAddress/pick_address_screen.dart';
import 'package:farmgate/src/screens/profile/edit_profile_screen.dart';
import 'package:farmgate/src/screens/profile/widgets/farm_manager_screen.dart';
import 'package:farmgate/src/screens/register/register_screen.dart';
import 'package:farmgate/src/screens/setting/setting_screen.dart';
import 'package:farmgate/src/screens/user_type/request_user_type.dart';
import 'package:flutter/material.dart';

import 'src/screens/splash/splash_screen.dart';

class PageViewTransition<T> extends MaterialPageRoute<T> {
  PageViewTransition({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') return child;
    if (animation.status == AnimationStatus.reverse)
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

class AppRoute {
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String loginWithPhoneScreen = 'loginWithPhoneScreen';
  static const String homeScreen = '/homeScreen';
  static const String newDetailScreen = '/newDetailScreen';
  static const String addNewScreen = '/addNewScreen';
  static const String userPlaceScreen = '/userPlaceScreen';
  static const String searchPlaceScreen = '/searchPlaceScreen';
  static const String myVoucherScreen = '/myVoucherScreen';
  static const String useMyVoucherScreen = '/useMyVoucherScreen';
  static const String helpScreen = '/helpScreen';
  static const String settingScreen = '/settingScreen';
  static const String editProfileScreen = '/EditProfileScreen';
  static const String registerScreen = '/registerScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String webScreen = '/webScreen';
  static const String changePasswordScreen = '/changePassWordScreen';
  static const String informationAppScreen = '/informationAppScreen';
  static const String languagesScreen = '/languagesScreen';
  static const String contactScreen = '/contactScreen';
  static const String viewFullVideoScreen = '/viewFullVideoScreen';
  static const String commentScreen = '/commentScreen';
  static const String gradenBoderScreen = '/gradenBoderScreen';
  static const String myGardenScreen = '/myGardenScreen';
  static const String detailGardenScreen = '/detailGardenScreen';
  static const String treeScreen = '/treeScreen';
  static const String listPlant = "/plantprotect_screen";
  static const String treeShowAllScreen = '/treeShowAllScreen';
  static const String addMembersScreen = '/addMembersScreen';
  static const String showAllHistoryScreen = '/showAllHistoryScreen';
  static const String addGardenScreen = '/addGardenScreen';
  static const String editGardenScreen = '/editGardenScreen';
  static const String forgotPasswordPhoneScreen = '/forgotPasswordPhone';
  static const String pickAddressScreen = '/pickAddressScreen';
  static const String treeShowAllAndPickTree = '/treeShowAllAndPickTree';
  static const String myQrCodeScreen = '/myQrCodeScreen';
  static const String allPeople = '/allPeople';
  static const String userType = '/userType';
  static const String farmManager = '/farm_manager';
  static const String managerProject = '/managerProject';
  static const String managerProjectDetail = '/managerProjectDetail';
  static const String allProject = '/allProject';
  static const String transaction4cScreen = '/transaction4cScreen';
  static const String confirmTransactionScreen = '/confirmTransactionScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final agrs = settings.arguments as Map<String, dynamic> ?? {};
    switch (settings.name) {
      case '/':
      case splashScreen:
        return PageViewTransition(
            builder: (_) => SplashScreen(), settings: settings);
      case homeScreen:
        return PageViewTransition(
            builder: (_) => HomeScreen.provider(), settings: settings);
      case loginScreen:
        return PageViewTransition(
            builder: (_) => LoginScreen.provider(), settings: settings);
      case loginWithPhoneScreen:
        return PageViewTransition(
            builder: (_) => LoginWithPhoneScreen.provider(),
            settings: settings);
      case addNewScreen:
        return PageViewTransition(
            builder: (_) => AddNewsScreen.provider(), settings: settings);
      case userPlaceScreen:
        return PageViewTransition(
            builder: (_) => UserPlaceScreen.provider(), settings: settings);
      case gradenBoderScreen:
        return PageViewTransition(
            builder: (_) => GradenBoderScreen.provider(), settings: settings);
      case registerScreen:
        return PageViewTransition(builder: (_) => RegisterScreen.provider());
      case forgotPasswordScreen:
        return PageViewTransition(
            builder: (_) => ForgotPasswordScreen.provider());
      case searchPlaceScreen:
        return PageViewTransition(
          builder: (_) => SearchPlaceScreen.provider(agrs['cubit']),
          settings: settings,
        );
      case webScreen:
        return PageViewTransition(
          builder: (_) => WebSupport.provider(model: agrs['webModel']),
          settings: settings,
        );
      case editProfileScreen:
        return PageViewTransition(
          builder: (_) => EditProfileScreen.provider(),
          settings: settings,
        );
      case changePasswordScreen:
        return PageViewTransition(
            builder: (_) => ChangePasswordScreen.provider(),
            settings: settings);
      case informationAppScreen:
        return PageViewTransition(
            builder: (_) => InformationAppScreen.provider(),
            settings: settings);
      case helpScreen:
        return PageViewTransition(
            builder: (_) => HelpScreen.provider(), settings: settings);
      case languagesScreen:
        return PageViewTransition(
            builder: (_) => LanguagesScreen.provider(), settings: settings);
      case settingScreen:
        return PageViewTransition(
            builder: (_) => SettingScreen.provider(), settings: settings);
      case newDetailScreen:
        return PageViewTransition(
            builder: (_) => NewDetailScreen.provider(
                urlImg: agrs['urlImg'],
                titleAppbar: agrs['titleAppbar'],
                category: agrs['category'],
                heroTag: agrs['heroTag'],
                isVideo: agrs['isVideo']),
            settings: settings);
      case commentScreen:
        return PageViewTransition(
            builder: (_) => CommentScreen.provider(
                titleAppbar: agrs['titleAppbar'], title: agrs['title']),
            settings: settings);
      case informationAppScreen:
        return PageViewTransition(
            builder: (_) => InformationAppScreen(), settings: settings);
      case contactScreen:
        return PageViewTransition(
            builder: (_) => ContactScreen.provider(), settings: settings);
      case myGardenScreen:
        return PageViewTransition(
            builder: (_) => MyGradenScreen.provider(), settings: settings);
      case treeScreen:
        return PageViewTransition(
            builder: (_) => TreeScreen.provider(gardenId: agrs['gardenId']),
            settings: settings);

      case detailGardenScreen:
        return PageViewTransition(
            builder: (_) => GardenDetailWidget.provider(
                id: agrs['id'],
                img: agrs['img'],
                herotag: agrs['heroTag'],
                data: agrs['data']),
            settings: settings);
      case viewFullVideoScreen:
        return PageViewTransition(
            builder: (_) => VideoDetail(
                  videoLink: agrs['videoLink'],
                  position: agrs['position'],
                ),
            settings: settings);
      case listPlant:
        return PageViewTransition(
            builder: (_) => ProtectProductScreen.provider(
                gardenId: agrs['idGarden'], actionGarden: agrs['action_type']),
            settings: settings);

      case treeShowAllScreen:
        return PageViewTransition(
          builder: (_) => TreeShowAllScreen.provider(
              treeList: agrs['treeList'], gardenId: agrs['idGarden']),
        );

      case addMembersScreen:
        return PageViewTransition(
            builder: (_) => AddMembersScreen.provider(
                agrs['data'], agrs['status'], agrs['idGarden']),
            settings: settings);

      case showAllHistoryScreen:
        return PageViewTransition(
            builder: (_) => ShowAllHistoryScreen.provider(agrs['gardenId']),
            settings: settings);

      case allPeople:
        return PageViewTransition(
            builder: (_) =>
                AllPeopleScreen.provider(agrs['isDelete'], agrs['garden']),
            settings: settings);

      case addGardenScreen:
        return PageViewTransition(
            builder: (_) => AddGardenScreen.provider(), settings: settings);

      case editGardenScreen:
        return PageViewTransition(
            builder: (_) => EditGardenScreen.provider(agrs['garden']),
            settings: settings);
      case forgotPasswordPhoneScreen:
        return PageViewTransition(
            builder: (_) => ForgotPasswordPhoneScreen.provider(),
            settings: settings);
      case pickAddressScreen:
        return PageViewTransition(
            builder: (_) => PickAddressScreen.provider(agrs['profileResponse']),
            settings: settings);
      case treeShowAllAndPickTree:
        return PageViewTransition(
            builder: (_) =>
                TreeShowAllAndPickTree.provider(idGarden: agrs['idGarden']),
            settings: settings);
      case myQrCodeScreen:
        return PageViewTransition(
            builder: (_) => MyQrCodeScreen.provider(), settings: settings);

      case userType:
        return PageViewTransition(
            builder: (_) => RequestUserTypeScreen.provider(),
            settings: settings);

      case farmManager:
        return PageViewTransition(
            builder: (_) => FarmManagerScreen(), settings: settings);

      case managerProject:
        return PageViewTransition(
            builder: (_) => ManagerProjectScreen.provider(),
            settings: settings);

      case managerProjectDetail:
        return PageViewTransition(
            builder: (_) =>
                ManagerProjectDetailScreen.provider(project: agrs['project']),
            settings: settings);

      case allProject:
        return PageViewTransition(
            builder: (_) => AllProjectScreen.provider(), settings: settings);

      case transaction4cScreen:
        return PageViewTransition(
            builder: (_) => Transaction4cScreen.provider(agrs['project']),
            settings: settings);

      case confirmTransactionScreen:
        return PageViewTransition(
            builder: (_) =>
                ConfirmTransactionScreen.provider(id: agrs['requestID']),
            settings: settings);

      default:
        return PageViewTransition(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
