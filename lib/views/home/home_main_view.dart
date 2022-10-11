import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';


class HomeMainView extends StatelessWidget {
  const HomeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: const [
          DomainBar(),
        ],),

    );
  }
}
