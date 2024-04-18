import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PrivacyPolicy extends StatefulWidget {

  const PrivacyPolicy({super.key});
  @override
  State<PrivacyPolicy> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<PrivacyPolicy> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://www.freeprivacypolicy.com/live/9c0c59af-67f7-4b27-bb56-2a7346815a68'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50, // Set this height
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),
          onPressed:() => Navigator.pop(context, false),
        ),
        title: Text("Privacy Policy"),
        backgroundColor: Colors.black,
      ),

      body: WebViewWidget(
        controller: controller,

      ),
    );
  }
}