import 'package:flutter/material.dart';

import 'package:webview_media/webview_flutter.dart';

class TextItemWebView extends StatelessWidget {
  final _linkUrl;

  TextItemWebView(this._linkUrl);
  @override
  Widget build(BuildContext context) {
    print('intextitemwebview: $_linkUrl');
    WebViewController _controller;
    return WebView(
      initialUrl: _linkUrl,
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
    );
  }
}