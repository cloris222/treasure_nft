import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Text('LoginMainView')),
        bottomNavigationBar: AppBottomNavigationBar(
          initType: AppNavigationBarType.typeNull,
        ));
  }
}
