import 'package:flutter/material.dart';

import 'package:webview_media/webview_flutter.dart';

class TextItemWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    return WebView(
      initialUrl: 'https://google.com',
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
    );
  }
}