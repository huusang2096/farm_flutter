import 'package:farmgate/src/common/config.dart';
import 'package:farmgate/src/model/detail/webview_model.dart';
import 'package:farmgate/src/screens/newsDetail/bloc/detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:simplest/simplest.dart';

class WebSupport extends StatefulWidget {
  WebViewModel model;

  WebSupport(this.model);

  static provider({WebViewModel model}) {
    return BlocProvider(
        create: (context) => DetailCubit(), child: WebSupport(model));
  }

  @override
  _WebSupportState createState() => _WebSupportState();
}

class _WebSupportState extends State<WebSupport> {
  InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: greyColor),
        elevation: 1,
      ),
      body: Builder(builder: (BuildContext context) {
        return _buildWebView(widget.model);
      }),
    );
  }

  InAppWebView _buildWebView(WebViewModel webViewModel) {
    var initialOptions = webViewModel.options;
    initialOptions.android.safeBrowsingEnabled = true;
    initialOptions.android.disableDefaultErrorPage = true;
    initialOptions.android.supportMultipleWindows = true;

    initialOptions.ios.allowsLinkPreview = true;
    initialOptions.ios.isFraudulentWebsiteWarningEnabled = true;

    return InAppWebView(
      initialOptions: initialOptions,
      windowId: webViewModel.windowId,
      onCloseWindow: (controller) {
        Navigator.of(context).pop();
      },
    );
  }
}
