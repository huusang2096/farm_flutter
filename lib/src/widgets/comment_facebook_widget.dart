import 'package:farmgate/routes.dart';
import 'package:farmgate/src/model/detail/webview_model.dart';
import 'package:farmgate/src/screens/newsDetail/widget/util.dart';
import 'package:farmgate/src/screens/shimmer/comment_simmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:simplest/simplest.dart';

class CommentFaceWidget extends StatefulWidget {
  final String appkey;
  final String url;
  const CommentFaceWidget({Key key, @required this.appkey, @required this.url})
      : super(key: key);

  @override
  _CommentFaceWidgetState createState() => _CommentFaceWidgetState();
}

class _CommentFaceWidgetState extends State<CommentFaceWidget> {
  String html = '';
  WebViewModel webViewModel;
  InAppWebViewController _webViewController;
  final _debouncer = Debouncer(milliseconds: 2000);
  bool isLoading = true;

  @override
  void initState() {
    html = "<html lang=\"vn\">\n" +
        "<head></head>\n" +
        "<body>\n" +
        "<div id=\"fb-root\"></div>\n" +
        "<script async defer crossorigin=\"anonymous\" src=\"https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v9.0&appId=" +
        widget.appkey +
        "&autoLogAppEvents=1\" nonce=\"3bH1reIw\"></script>\n" +
        "<div class=\"fb-comments\" data-href=\"" +
        widget.url +
        "\" data-numposts=\"5\" data-mobile=\"true\" data-width=\"200\" ></div>\n" +
        "</body>\n" +
        "</html>";
    webViewModel = WebViewModel(url: widget.url);
    super.initState();
  }

  @override
  void dispose() {
    webViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: _buildWebView(html, widget.url)),
          isLoading
              ? Container(color: Colors.white, child: CommentShimmer())
              : SizedBox.shrink()
        ],
      ),
    );
  }

  InAppWebView _buildWebView(String html, String url) {
    var initialOptions = webViewModel.options;
    initialOptions.android.safeBrowsingEnabled = true;
    initialOptions.android.disableDefaultErrorPage = true;
    initialOptions.android.supportMultipleWindows = true;
    initialOptions.android.textZoom = 250;

    initialOptions.ios.allowsLinkPreview = true;
    initialOptions.ios.isFraudulentWebsiteWarningEnabled = true;
    initialOptions.ios.minimumZoomScale = 10;

    initialOptions.crossPlatform.javaScriptCanOpenWindowsAutomatically = true;

    return InAppWebView(
      initialUrl: url,
      initialOptions: initialOptions,
      windowId: webViewModel.windowId,
      gestureRecognizers: Set()
        ..add(
          Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(),
          ), // or null
        ),
      onProgressChanged: (InAppWebViewController controller, int progress) {
        if (progress == 100) {
          _debouncer.run(() {
            setState(() {
              this.isLoading = false;
            });
          });
        }
      },
      onWebViewCreated: (controller) async {
        _webViewController = controller;
        webViewModel.webViewController = controller;

        _webViewController?.loadData(
            data: html, baseUrl: url, androidHistoryUrl: url);

        webViewModel.url = url;
        webViewModel.isSecure = false;
      },
      onLoadStart: (controller, url) async {
        webViewModel.isSecure = Util.urlIsSecure(url);
        webViewModel.url = url;
        webViewModel.loaded = true;
        webViewModel.setLoadedResources([]);
        webViewModel.setJavaScriptConsoleResults([]);
      },
      androidOnPermissionRequest: (InAppWebViewController controller,
          String origin, List<String> resources) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      onCreateWindow: (controller, createWindowRequest) async {
        WebViewModel model = WebViewModel(
            url: createWindowRequest.url,
            windowId: createWindowRequest.windowId);
        Navigator.of(context)
            .pushNamed(AppRoute.webScreen, arguments: {'webModel': model});
        return true;
      },
    );
  }
}
