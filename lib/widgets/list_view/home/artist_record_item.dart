
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';


class ArtistRecordItemView extends StatefulWidget {
  const ArtistRecordItemView({super.key, required this.itemData});

  final ArtistRecord itemData;

  @override
  State<StatefulWidget> createState() => _ArtistRecordItem();

}

class _ArtistRecordItem extends State<ArtistRecordItemView> {
  HomeMainViewModel viewModel = HomeMainViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: UIDefine.getScreenHeight(15),
        padding: EdgeInsets.all(UIDefine.getScreenHeight(1.5)),
        child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${widget.itemData.sort}'),
              viewModel.getPadding(1),

              /// Avatar
              SizedBox(
                height: UIDefine.getScreenWidth(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(widget.itemData.avatarUrl, fit: BoxFit.fill),
                ),
              ),
              viewModel.getPadding(1),

              Expanded(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// NAME
                  Text(widget.itemData.name,
                    style: TextStyle(
                        fontSize: UIDefine.fontSize14,
                        color: AppColors.textBlack
                    ),
                  ),

                  viewModel.getPadding(1),

                  /// Vol. & Sales
                  Row(children: [
                      Text('Vol.',
                        style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textGrey
                        ),
                      ),

                    viewModel.getPadding(1),

                    Text(viewModel.getVolAndSalesFormat(widget.itemData.ydayAmt),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textBlack
                        ),
                      ),

                    viewModel.getPadding(0.5),

                    SizedBox(
                        height: UIDefine.getScreenWidth(5),
                        child:Image.asset(AppImagePath.tetherImg),
                      ),

                      viewModel.getPadding(3),

                      Text('Sales',
                        style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textGrey
                        ),
                      ),

                    viewModel.getPadding(1),

                    Text(viewModel.getVolAndSalesFormat(widget.itemData.amtTotal),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textBlack
                        ),
                      ),

                    viewModel.getPadding(0.5),

                    SizedBox(
                        height: UIDefine.getScreenWidth(5),
                        child:Image.asset(AppImagePath.tetherImg),
                      ),

                    ],),
                ],),),


              Container(
                  alignment: Alignment.centerRight,
                  child:Image.asset(AppImagePath.downArrowGrey)
              ),

            ]));
  }

}