import 'dart:async';

import 'package:flutter/material.dart';

import '../../constant/ui_define.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({
    Key? key,
    this.size,
    this.marginVertical
  }) : super(key: key);
  double? size;
  double? marginVertical;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  late Timer _countdownTimer;
  List<List<double>> list = [
    [1, 0.6, 0.2],
    [0.2, 1, 0.6],
    [0.2, 0.6, 1],
    [0.6, 0.2, 0.1],
  ];

  @override
  void initState() {
    countdownFunction();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _countdownTimer.cancel();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(3, (index) => _buildCircle(index)),
    );
  }

  void countdownFunction() {
    _countdownTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        List<double> first = list.removeAt(0);
        list.add(first);
      });
    });
  }

  Widget _buildCircle(int index) {
    return Container(
      width: widget.size?? UIDefine.getPixelWidth(6),
      height: widget.size?? UIDefine.getPixelWidth(6),
      margin: EdgeInsets.symmetric(
        horizontal: index == 1 ? UIDefine.getPixelWidth(6) : 0,
        vertical: widget.marginVertical?? UIDefine.getPixelWidth(8),
      ),
      child: CircleAvatar(backgroundColor: Colors.white.withOpacity(list.first[index])),
    );
  }
}
