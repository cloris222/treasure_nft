import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/global_data.dart';

class ServerWebPage extends StatelessWidget {
  const ServerWebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String webUrl =
        'https://chatlink.mstatik.com/widget/standalone.html?eid=4bb3164096b2a0ba26d59a8a77dad628';

    return Scaffold(
      appBar: CustomAppBar.getServerAppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(webUrl),
            headers: {"Authorization": "Bearer ${GlobalData.userToken}"}),
      ),
    );
  }
}
