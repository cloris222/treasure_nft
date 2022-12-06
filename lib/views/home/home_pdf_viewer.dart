import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';


class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  final String title;
  final String assetPath;

  @override
  State<StatefulWidget> createState() {
    return PDFViewerPageState();
  }
}

class PDFViewerPageState extends State<PDFViewerPage> {
  HomeMainViewModel viewModel = HomeMainViewModel();

  static const int _initialPage = 1;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.assetPath),
      initialPage: _initialPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCornerAppBar(() {
        viewModel.popPage(context);
      }, widget.title),

      body:PdfViewPinch(
        controller: _pdfController,
        onDocumentLoaded: (document) {
          setState(() {
            _allPagesCount = document.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            _actualPageNumber = page;
          });
        },
      ),
    );
  }

}

