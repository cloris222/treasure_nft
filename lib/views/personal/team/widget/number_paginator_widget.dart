import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/view_models/personal/team/number_paginator_controller.dart';
import 'package:treasure_nft_project/views/personal/team/widget/paginator_button.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

class NumberPaginatorWidget extends StatefulWidget {
  final int totalPages;
  final Function(int)? onPageChange;

  const NumberPaginatorWidget({
    Key? key,
    required this.totalPages,
    this.onPageChange,
  }) : super(key: key);

  @override
  NumberPaginatorWidgetState createState() => NumberPaginatorWidgetState();
}

class NumberPaginatorWidgetState extends State<NumberPaginatorWidget> {
  late PaginatorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PaginatorController();
    _controller.addListener(() {
      widget.onPageChange?.call(_controller.currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Visibility(
              maintainState: true, maintainAnimation:true, maintainSize: true,
              visible: _controller.currentPage > 1,
              child: PaginatorButton(
                onPressed: () {
                  GlobalData.printLog('leftButtonPress: ${_controller.currentPage}');
                  _controller.currentPage > 0
                      ? _controller.prev() : null;
                  setState(() {});
                },
                child: _controller.currentPage > 0
                    ? const Icon(Icons.chevron_left) : Container(),
              ),
            ),


            Visibility(
              maintainState: true, maintainAnimation:true, maintainSize: true,
              visible: _controller.currentPage > 1,
              child: PaginatorButton(
                onPressed: () {},
                child: Text('${_controller.currentPage-1}',
                    style:  CustomTextStyle.getBaseStyle(
                      color: AppColors.textGrey,
                    )
                ),
              ),
            ),

            PaginatorButton(
              onPressed: () {},
              selected: true,
              child: Text('${_controller.currentPage}',
                  style:  CustomTextStyle.getBaseStyle(
                    color: AppColors.mainThemeButton
                  )
              ),
            ),


            Visibility(
              maintainState: true, maintainAnimation:true, maintainSize: true,
              visible:_controller.currentPage < widget.totalPages,
              child: PaginatorButton(
                onPressed: () {},
                child: Text('${_controller.currentPage+1}',
                    style:  CustomTextStyle.getBaseStyle(
                      color: AppColors.textGrey,
                    )
                ),
              ),
            ),

            Visibility(
              maintainState: true, maintainAnimation:true, maintainSize: true,
              visible:_controller.currentPage < widget.totalPages,
              child: PaginatorButton(
                onPressed: () {
                  _controller.currentPage < widget.totalPages
                      ? _controller.next() : null;
                  setState(() {});
                },
                child: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      );
  }

}
