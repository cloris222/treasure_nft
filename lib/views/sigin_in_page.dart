import 'package:flutter/material.dart';

import '../models/http/parameter/sign_in_data.dart';

///MARK: 每日簽到
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.data}) : super(key: key);
  final SignInData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: _buildItem,
          itemCount: data.finishedDateList.length,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Text(data.finishedDateList[index]);
  }
}
