import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';

///MARK: 漸進式讀取圖片
class GraduallyNetworkImage extends StatelessWidget {
  const GraduallyNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.errorWidget,
      this.loadWidget,
      this.child,
      this.childAlignment,
      this.childPadding,
      this.imageWidgetBuilder})
      : super(key: key);
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? loadWidget;

  /// Optional builder to further customize the display of the image.
  /// 供Container背景用
  final Widget? child;
  final AlignmentGeometry? childAlignment;
  final EdgeInsetsGeometry? childPadding;

  ///MARK: 與child只能擇一使用
  final ImageWidgetBuilder? imageWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    return _buildLoadNormal();
  }

  Widget _buildLoadingIcon() {
    return Center(child: loadWidget ?? Image.asset(AppImagePath.preloadIcon));
  }

  Widget _buildErrorIcon() {
    return Center(child: errorWidget ?? const Icon(Icons.cancel_rounded));
  }

  Widget _buildLoadLowPath() {
    String lowUrl;
    if (imageUrl.contains('.')) {
      int index = imageUrl.lastIndexOf('.');
      lowUrl =
          '${imageUrl.substring(0, index)}_compre${imageUrl.substring(index)}';
    } else {
      lowUrl = imageUrl;
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: lowUrl,
      imageBuilder: _buildImageBuilder(),
      placeholder: (context, url) => _buildLoadingIcon(),
      errorWidget: (context, url, error) => _buildLoadNormal(fail: true),
    );
  }

  Widget _buildLoadNormal({bool fail = false}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: imageUrl,
      imageBuilder: _buildImageBuilder(),
      placeholder: (context, url) =>
          fail ? _buildLoadingIcon() : _buildLoadLowPath(),
      errorWidget: (context, url, error) => _buildErrorIcon(),
    );
  }

  ImageWidgetBuilder? _buildImageBuilder() {
    return child != null
        ? (context, imageProvider) => Container(
            alignment: childAlignment,
            padding: childPadding,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
            child: child)
        : imageWidgetBuilder;
  }
}
