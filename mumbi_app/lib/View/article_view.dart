import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thai giáo'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(icon: Icon(Icons.search),
                onPressed: () => {}
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(icon: Image.asset(bookmark),
                  onPressed: () => {}
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        )
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: (WebViewController webViewController){
            _completer.complete(webViewController);
          },
        ),
      ),
    );
  }
}
