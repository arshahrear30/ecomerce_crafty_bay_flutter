import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/product_card_item.dart';
import 'auth/product_controller.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, this.category, this.categoryId});

  final String? category;
  final int? categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.categoryId != null) {
      Get.find<ProductController>()
          .getProductList(categoryId: widget.categoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? 'Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<ProductController>(builder: (productController) {
          return Visibility(
            visible: productController.inProgress == false,
            replacement: const CenterCircularProgressIndicator(),
            child: Visibility(
              visible: productController.productListModel.productList?.isNotEmpty ?? false,
              replacement: const Center(
                child: Text('No products'),
              ),


              child: GridView.builder(
                itemCount:
                productController.productListModel.productList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //SliverGridDelegateWithFixedCrossAxisCount Grid-এর layout control করে abong
                  //এটা বলে দেয় GridView-তে এক লাইনে কয়টা item থাকবে এবং item-এর size/spacing কেমন হবে।
                    crossAxisCount: 3,//মানে এক row তে ৩টা product card থাকবে।
                    childAspectRatio: 0.90,
                    mainAxisSpacing: 8,//Row এর vertical gap।
                    crossAxisSpacing: 4),//Column এর horizontal gap।
                itemBuilder: (context, index) {
                  return FittedBox( //FittedBox child widget-কে available space এর ভিতরে fit করায়।
                    child: ProductCardItem(
                      product:
                      productController.productListModel.productList![index],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}