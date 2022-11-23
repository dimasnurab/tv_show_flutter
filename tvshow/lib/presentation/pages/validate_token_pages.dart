import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tvshow/config/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ValidateTokenPages extends StatefulWidget {
  const ValidateTokenPages({Key? key}) : super(key: key);

  @override
  State<ValidateTokenPages> createState() => _ValidateTokenPagesState();
}

class _ValidateTokenPagesState extends State<ValidateTokenPages> {
  var token = Get.arguments['token'];
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: ConstantApp.baseUrlValidate + "${token}",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            if (url.split('/').last == 'allow') {
              Get.back(result: 'success');
            }
          },
          onPageFinished: (String url) {
            if (url.split('/').last == 'allow') {
              Get.back(result: 'success');
            }
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
