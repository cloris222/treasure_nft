import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../constant/global_data.dart';
import '../constant/theme/app_colors.dart';

class ServerWebPage extends StatefulWidget {
  const ServerWebPage({Key? key}) : super(key: key);

  @override
  State<ServerWebPage> createState() => _ServerWebPageState();
}

class _ServerWebPageState extends State<ServerWebPage> {
  bool showLoading = true;

  @override
  Widget build(BuildContext context) {
    String webUrl =
        'https://chatlink.mstatik.com/widget/standalone.html?eid=4bb3164096b2a0ba26d59a8a77dad628';
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, bottom: 10),
            child: Stack(children: [
              InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse(webUrl),
                      headers: {
                        "Authorization": "Bearer ${GlobalData.userToken}"
                      }),
                  onLoadStart: _onLoadStart,
                  onLoadStop: _onLoadingStop),
              Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                      onPressed: () {
                        BaseViewModel().popPage(context);
                      },
                      icon:  Text(
                        'X',
                        style: AppTextStyle.getBaseStyle(
                            color:  Colors.white,
                            fontWeight: FontWeight.w500),
                      ))),
              Visibility(
                  visible: showLoading,
                  child: LoadingAnimationWidget.hexagonDots(
                      color: AppColors.textBlack, size: 30))
            ])));
  }

  void _onLoadStart(InAppWebViewController controller, Uri? url) {
    setState(() {
      showLoading = true;
    });
  }

  void _onLoadingStop(InAppWebViewController controller, Uri? url) {
    setState(() {
      showLoading = false;
    });
  }
}
