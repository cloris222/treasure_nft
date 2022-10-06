import 'package:flutter/material.dart';

abstract class BaseStateLessListView extends StatelessWidget {
  const BaseStateLessListView(
      {Key? key,
      this.setScrollPhysicsNull,
      this.shrinkWrap = false,
      this.padding})
      : super(key: key);
  final ScrollPhysics? setScrollPhysicsNull;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  void init(BuildContext context);

  Widget createItemBuilder(BuildContext context, int index);

  Widget createSeparatorBuilder(BuildContext context, int index);

  int getItemCount();

  @override
  Widget build(BuildContext context) {
    init(context);
    return ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap
            ? const NeverScrollableScrollPhysics()
            : setScrollPhysicsNull,
        padding: padding,
        itemBuilder: (context, index) {
          return createItemBuilder(context, index);
        },
        itemCount: getItemCount(),
        separatorBuilder: (BuildContext context, int index) {
          return createSeparatorBuilder(context, index);
        });
  }
}
