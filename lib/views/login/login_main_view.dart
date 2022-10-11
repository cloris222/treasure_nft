import 'package:flutter/material.dart';

import '../../widgets/domain_bar.dart';

class LoginMainView extends StatelessWidget {
  const LoginMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DomainBar(),
      Text('login')
    ],);
  }
}
