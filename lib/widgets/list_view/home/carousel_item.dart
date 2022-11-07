
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';

class CarouselItemView extends StatefulWidget {
  const CarouselItemView({super.key,
    required this.itemData,
    required this.decorationImage,});

  final HomeCarousel itemData;

  final Widget decorationImage;

  @override
  State<StatefulWidget> createState() => _CarouselItem();

}

class _CarouselItem extends State<CarouselItemView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(UIDefine.getScreenHeight(1.5)),
        child:Container(

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.textWhite,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5
                ),
              ]),

          child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: widget.decorationImage,

                      // Image.network(widget.itemData.imageUrl,
                      //   fit: BoxFit.fill,
                      // ),
                  ),
                ),

                Container(
                    margin: EdgeInsets.all(UIDefine.getScreenHeight(2)),
                    child:Text(widget.itemData.name,
                      style: TextStyle(
                        fontSize: UIDefine.fontSize16,
                        fontWeight: FontWeight.w300,
                      ),
                    )),

              ]),
        ));
  }

}