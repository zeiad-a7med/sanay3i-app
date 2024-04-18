import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Covid extends StatefulWidget {

  const Covid({super.key});
  @override
  State<Covid> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<Covid> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://www.cdc.gov/coronavirus/2019-ncov/easy-to-read/prevent-getting-sick/prevention.html'),
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
        title: Text("Covid-19 Safety"),
        backgroundColor: Colors.black,
      ),

      body: WebViewWidget(
        controller: controller,

      ),
    );
  }
}