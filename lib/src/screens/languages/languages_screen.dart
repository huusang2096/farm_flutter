import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/screens/languages/cubit/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class LanguagesScreen extends CubitWidget<LanguagesCubit, LanguagesState> {
  static BlocProvider<LanguagesCubit> provider() {
    return BlocProvider<LanguagesCubit>(
      create: (context) => LanguagesCubit(),
      child: LanguagesScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    super.afterFirstLayout(context);
  }

  @override
  void listener(BuildContext context, LanguagesState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, LanguagesState state) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.separated(
        itemBuilder: (_, index) => _itemWidget(index, context),
        separatorBuilder: (_, index) => Divider(
          height: 1.0,
        ),
        itemCount: supportedLocales.length,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: greyColor),
      title: Text(
        'languages'.tr,
        style: headingBlack18,
      ),
      automaticallyImplyLeading: true,
      elevation: 1.0,
      centerTitle: true,
    );
  }

  Widget _itemWidget(int index, BuildContext context) {
    final _locale = supportedLocales[index];
    final _isSelected = Get.locale.languageCode == _locale.languageCode;
    return InkWell(
      onTap: () => context.read<LanguagesCubit>().onSelectLocale(_locale),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Container(
              width: 50,
              child: Center(
                child: _isSelected
                    ? FaIcon(
                        FontAwesomeIcons.check,
                        color: primaryColor,
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _locale.languageCode == 'vi'
                  ? Images.vnFlag.loadImage(size: 40)
                  : Images.enFlag.loadImage(size: 40),
            ),
            Expanded(
              child: Text(
                _locale.languageCode.tr,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
