import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../constant/global_data.dart';

class ServerWebPage extends StatelessWidget {
  const ServerWebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String webUrl =
        'https://chatlink.mstatik.com/widget/standalone.html?eid=4bb3164096b2a0ba26d59a8a77dad628';

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, bottom: 10),
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(webUrl),
                  headers: {"Authorization": "Bearer ${GlobalData.userToken}"}),
            ),
            IconButton(
                onPressed: () {
                  BaseViewModel().popPage(context);
                },
                icon: const Text(
                  'X',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
