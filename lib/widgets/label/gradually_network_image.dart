import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

///MARK: 漸進式讀取圖片
class GraduallyNetworkImage extends StatelessWidget {
  const GraduallyNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.cacheWidth,
      this.width,
      this.height,
      this.fit,
      this.errorWidget,
      this.loadWidget,
      this.child,
      this.childAlignment,
      this.childPadding,
      this.imageWidgetBuilder,
      this.showNormal})
      : super(key: key);
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? loadWidget;
  final int? cacheWidth;
  final bool? showNormal;

  /// Optional builder to further customize the display of the image.
  /// 供Container背景用
  final Widget? child;
  final AlignmentGeometry? childAlignment;
  final EdgeInsetsGeometry? childPadding;

  ///MARK: 與child只能擇一使用
  final ImageWidgetBuilder? imageWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    // return _buildLoadNormal();
    ///MARK: 暫時不讀壓圖
    return _buildLoadLowPath(loadNormal: showNormal ?? false);
  }

  Widget _buildLoadingIcon() {
    return Center(child: loadWidget ?? Image.asset(AppImagePath.preloadIcon));
  }

  Widget _buildErrorIcon() {
    return Center(child: errorWidget ?? const Icon(Icons.cancel_rounded));
  }

  Widget _buildLoadLowPath({bool loadNormal = true}) {
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
      memCacheWidth: cacheWidth ?? 480,
      cacheManager: CacheManager(
        Config("flutterCampus", stalePeriod: const Duration(minutes: 5)),
      ),
      imageBuilder: _buildImageBuilder(),
      placeholder: (context, url) =>
          Container(width: width, height: width, color: Colors.white),
      errorWidget: (context, url, error) =>
          loadNormal ? _buildLoadNormal(fail: true) : _buildErrorIcon(),
    );
  }

  Widget _buildLoadNormal({bool fail = false}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: imageUrl,
      memCacheWidth: cacheWidth ?? 480,
      cacheManager: CacheManager(
        Config("flutterCampus", stalePeriod: const Duration(minutes: 5)),
      ),
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
