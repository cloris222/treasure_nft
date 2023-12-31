// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/api/ios_payment_api.dart';
import 'package:treasure_nft_project/models/http/parameter/ios_purchase/ios_product_data.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/text_button_widget.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../constant/theme/app_animation_path.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../utils/ios_payment/consumable_store.dart';
import '../../../view_models/base_view_model.dart';
import '../../../widgets/appbar/custom_app_bar.dart';
import '../open_box_animation_page.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

class AppPurchase extends StatefulWidget {
  const AppPurchase({Key? key}) : super(key: key);

  @override
  State<AppPurchase> createState() => _AppPurchaseState();
}

class _AppPurchaseState extends State<AppPurchase> {
  final bool needBuyLimit = true;
  static const bool _kAutoConsume = true;

  static const String NFT_1 = 'com.treasurenft.level1';
  static const String NFT_2 = 'com.treasurenft.level2';
  static const String NFT_3 = 'com.treasurenft.level3';
  static const String NFT_4 = 'com.treasurenft.level4';

  static const List<String> _kProductIds = <String>[
    NFT_1,
    NFT_2,
    NFT_3,
    NFT_4,
  ];

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  List<IosProductData> _appProductList = [];

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      _subscription.resume();
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    /// 結束上一次購買流程
    var paymentWrapper = SKPaymentQueueWrapper();
    var transactions = await paymentWrapper.transactions();
    transactions.forEach((transaction) async {
      await paymentWrapper.finishTransaction(transaction);
    });

    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    /// call api check product list
    _appProductList = await IOSPaymentAPI().getPurchaseList();
    Set<String> productIds =
        Set<String>.from(_appProductList.map((e) => e.productId));
    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(productIds);

    /// 直接從蘋果後台取得資料
    // await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      var iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            Container(child: _buildProductList()),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: const [
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: Container(
        width: UIDefine.getWidth(),
        height: UIDefine.getHeight(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImagePath.backgroundLand),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
              child: const TitleAppBar(
                title: '',
              ),
            ),
            Expanded(
              child: Stack(
                children: stack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildProductList() {
    if (_loading) {
      return const Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...'))));
    }
    if (!_isAvailable) {
      return const Card();
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    List<Widget> productList = <Widget>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: AppTextStyle.getBaseStyle(
                  color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        PurchaseDetails? previousPurchase = purchases[productDetails.id];
        var imageName = '';
        var buttonName = '';
        var buttonColor = 0;
        switch (productDetails.id) {
          case NFT_1:
            imageName = AppImagePath.purchaseImg1;
            buttonName = 'Silver';
            buttonColor = 0XFF54514D;

            break;
          case NFT_2:
            imageName = AppImagePath.purchaseImg2;
            buttonName = 'Golden';
            buttonColor = 0XFFECAF46;

            break;
          case NFT_3:
            imageName = AppImagePath.purchaseImg3;
            buttonName = 'Platinum';
            buttonColor = 0XFF93A0D2;

            break;
          case NFT_4:
            imageName = AppImagePath.purchaseImg4;
            buttonName = 'Diamond';
            buttonColor = 0XFF79BAD2;

            break;
        }
        num weeklyPurchaseLimit = 0;
        num quantityPurchasedThisWeek = 0;
        for (var element in _appProductList) {
          if (productDetails.id == element.productId) {
            weeklyPurchaseLimit = element.weeklyPurchaseLimit;
            quantityPurchasedThisWeek = element.quantityPurchasedThisWeek;
            break;
          }
        }
        bool canBuy;
        if (needBuyLimit) {
          canBuy = (weeklyPurchaseLimit - quantityPurchasedThisWeek) > 0;
        } else {
          canBuy = true;
        }

        return Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(20)),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: UIDefine.getPixelWidth(15),
                              right: UIDefine.getPixelWidth(10)),
                          child: Image.asset(
                            AppImagePath.rewardGradient,
                          )),
                      Text(
                        productDetails.title,
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize24,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: UIDefine.getPixelWidth(15),
                        bottom: UIDefine.getPixelHeight(3)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("appPurchaseDescription"),
                      style: TextStyle(
                          color: Colors.grey, fontSize: UIDefine.fontSize14),
                    ),
                  ),
                  Visibility(
                    visible: needBuyLimit,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: UIDefine.getPixelWidth(15),
                          bottom: UIDefine.getPixelHeight(3)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        format(tr("appPurchaseLimit"), {
                          "value":
                              weeklyPurchaseLimit - quantityPurchasedThisWeek,
                          "limit": weeklyPurchaseLimit
                        }),
                        style: TextStyle(
                            color: Colors.grey, fontSize: UIDefine.fontSize14),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Image.asset(
                    imageName,
                    fit: BoxFit.fitWidth,
                    width: UIDefine.getWidth(),
                  ),
                  Positioned(
                      left: UIDefine.getWidth() * 0.65,
                      right: UIDefine.getPixelWidth(5),
                      bottom: UIDefine.getPixelHeight(5),
                      child: Visibility(
                        visible: canBuy,
                        child: TextButtonWidget(
                          setHeight: UIDefine.getPixelHeight(48),
                          radius: 10,
                          textAlign: TextAlign.center,
                          isFillWidth: true,
                          fontWeight: FontWeight.w500,
                          fontSize: UIDefine.fontSize16,
                          btnText: buttonName,
                          setMainColor: Color(buttonColor),
                          onPressed: () {
                            late PurchaseParam purchaseParam = PurchaseParam(
                              productDetails: productDetails,
                              applicationUserName: null,
                            );
                            if ((productDetails.id == NFT_1) ||
                                (productDetails.id == NFT_2) ||
                                (productDetails.id == NFT_3) ||
                                (productDetails.id == NFT_4)) {
                              _inAppPurchase
                                  .buyConsumable(
                                      purchaseParam: purchaseParam,
                                      autoConsume:
                                          _kAutoConsume || Platform.isIOS)
                                  .then((value) {});
                            } else {
                              _inAppPurchase.buyNonConsumable(
                                  purchaseParam: purchaseParam);
                            }
                          },
                        ),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    ));

    return Card(child: Column(children: productList));
  }

  Widget _buildRestoreButton() {
    if (_loading) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text('Restore purchases'),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
            ),
            onPressed: () => _inAppPurchase.restorePurchases(),
          ),
        ],
      ),
    );
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if ((purchaseDetails.productID == NFT_1) ||
        (purchaseDetails.productID == NFT_2) ||
        (purchaseDetails.productID == NFT_3) ||
        (purchaseDetails.productID == NFT_4)) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        ///支付中
        GlobalData.printLog('AAA-支付中 ${purchaseDetailsList.length}');
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error ||
            purchaseDetails.status == PurchaseStatus.canceled) {
          GlobalData.printLog('AAA-支付GG  ${purchaseDetailsList.length}');
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          GlobalData.printLog('AAA-購買成功');
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            /// check receipt api
            var response = await IOSPaymentAPI().postCheckIOSReceipt(
                purchaseDetails.verificationData.localVerificationData);
            deliverProduct(purchaseDetails);
            if (needBuyLimit) {
              for (int index = 0; index < _appProductList.length; index++) {
                if (_appProductList[index].productId ==
                    purchaseDetails.productID) {
                  _appProductList[index].quantityPurchasedThisWeek += 1;
                }
              }
            }

            /// 確認購買成功後顯示動畫＋商品圖
            await BaseViewModel().pushOpacityPage(
                context,
                OpenBoxAnimationPage(
                    imgUrl: response.result[0].imgUrl,
                    animationPath: AppAnimationPath.showOpenWinsBox,
                    backgroundColor:
                        AppColors.opacityBackground.withOpacity(0.65),
                    callBack: () {
                      setState(() {
                        //bOpen = true;
                      });
                    }));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<void> confirmPriceChange(BuildContext context) async {
    if (Platform.isIOS) {
      var iapStoreKitPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
