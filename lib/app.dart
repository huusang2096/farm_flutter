import 'package:farmgate/generated/locales.g.dart';
import 'package:farmgate/locator.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplest/simplest.dart';
import 'package:stacked_services/stacked_services.dart';

import 'routes.dart';
import 'src/common/storage/app_prefs.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Auto hide keyboard while clicking outside
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        translationsKeys: AppTranslation.translations,
        locale: supportedLocales.firstWhere(
            (locate) => locate.languageCode == locator<AppPref>().langCode),
        supportedLocales: supportedLocales,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: supportedLocales.first,
        theme: _buildThemeData(context),
        title: kAppName,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
        primaryColor: primaryColor,
        primaryTextTheme:
            GoogleFonts.arimoTextTheme(Theme.of(context).textTheme),
        textTheme: GoogleFonts.arimoTextTheme(Theme.of(context).textTheme));
  }
}
