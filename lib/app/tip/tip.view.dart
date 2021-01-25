import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TipScreen extends StatefulWidget {
  final String url;

  const TipScreen({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TipScreenState();
  }
}

class _TipScreenState extends State<TipScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebView(
      initialUrl: widget.url,
    );
  }
}
