import 'package:flutter/material.dart';

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
    return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(networkUrl),
        backgroundColor: backgroundColor);
  }
}
