import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';

class PaginatorButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool selected;
  final Widget child;

  const PaginatorButton({
    Key? key,
    required this.onPressed,
    this.selected = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(

              side: selected ? const BorderSide(
                color: AppColors.datePickerBorder,
                width: 2,
              ) :  const BorderSide(color: Colors.transparent, width: 0),

              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            foregroundColor: selected ? AppColors.mainThemeButton : AppColors.textGrey,
          ),
          child: child,
        ),
      ),
    );
  }
}
