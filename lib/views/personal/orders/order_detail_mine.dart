import 'package:flutter/cupertino.dart';

class OrderDetailMine extends StatefulWidget {
  const OrderDetailMine({Key? key}) : super(key: key);

  @override
  State<OrderDetailMine> createState() => _OrderDetailMineState();
}

class _OrderDetailMineState extends State<OrderDetailMine> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mine'),);
  }
}