import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewWidget extends StatelessWidget {
  const WebViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController _webViewController;
  final String _url = 'https://www.federalbank.co.in/fed-alert';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_webViewController != null) {
              _webViewController.canGoBack().then((canGoBack) {
                if (canGoBack) {
                  _webViewController.goBack();
                } 
              });
            }
          },
        ),
        title: Text('Web Page'),
      ),
      body: WebView(
        initialUrl: _url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
      ),
    );
  }
}
