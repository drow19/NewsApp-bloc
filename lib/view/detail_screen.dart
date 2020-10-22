import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailScreen extends StatefulWidget {
  final url;

  DetailScreen({@required this.url});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: WebView(
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
