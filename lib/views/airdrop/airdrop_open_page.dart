import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:gif/gif.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class AirdropOpenPage extends StatefulWidget {
  const AirdropOpenPage({Key? key, required this.level}) : super(key: key);
  final int level;

  @override
  State<AirdropOpenPage> createState() => _AirdropOpenPageState();
}

class _AirdropOpenPageState extends State<AirdropOpenPage>
    with TickerProviderStateMixin {
  late GifController openController;
  late GifController waitController;
  bool showOpen = true;

  @override
  void initState() {
    openController = GifController(vsync: this);
    openController.value=0;
    waitController = GifController(vsync: this);
    waitController.value=0;
    super.initState();
  }

  @override
  void dispose() {
    openController.dispose();
    waitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImagePath.airdropAnimateBg),
              fit: BoxFit.fill)),

      child: Center(
        child: showOpen ? buildOpenAnimate() : buildWaitAnimate(),
      ),
    ));
  }

  Widget buildOpenAnimate() {
    return Gif(
      image: AssetImage(
          format(AppAnimationPath.airdropOpen, {"level": widget.level})),
      autostart: Autostart.once,
      controller: openController,
      onFetchCompleted: () {
        setState(() {
          showOpen = false;
          waitController.reset();
        });
      },
    );
  }

  Widget buildWaitAnimate() {
    return Gif(
      image: AssetImage(
          format(AppAnimationPath.airdropWait, {"level": widget.level})),
      autostart: Autostart.once,
      controller: waitController,
      placeholder: (context) => const Text('Loading...'),
      onFetchCompleted: () {},
    );
  }
}
