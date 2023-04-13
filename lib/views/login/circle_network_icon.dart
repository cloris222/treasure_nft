import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

class CircleNetworkIcon extends StatelessWidget {
  const CircleNetworkIcon({
    Key? key,
    required this.networkUrl,
    this.radius = 25,
    this.backgroundColor = Colors.transparent,
    this.showNormal
  }) : super(key: key);
  final String networkUrl;
  final double radius;
  final Color backgroundColor;
  final bool? showNormal;

  @override
  Widget build(BuildContext context) {
    return GraduallyNetworkImage(
      showNormal: showNormal,
        imageUrl: networkUrl,
        width: radius*2,
        height: radius*2,
        imageWidgetBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
            backgroundColor: backgroundColor));
  }
}
