import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

class CircleNetworkIcon extends StatelessWidget {
  const CircleNetworkIcon({
    Key? key,
    required this.networkUrl,
    this.radius = 25,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);
  final String networkUrl;
  final double radius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GraduallyNetworkImage(
        imageUrl: networkUrl,
        imageWidgetBuilder: (context, imageProvider) => CircleAvatar(
            radius: radius,
            backgroundImage: imageProvider,
            backgroundColor: backgroundColor));
  }
}
