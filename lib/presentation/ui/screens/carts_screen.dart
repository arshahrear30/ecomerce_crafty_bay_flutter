import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/cart_list_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../utility/app_colours.dart';
import '../widgets/carts/cart_product_item.dart';
import '../widgets/center_circular_progress_indicator.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainBottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carts'),
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            if (cartListController.inProgress == true) {
              return const CenterCircularProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount:
                    cartListController.cartListModel.cartItemList?.length ?? 0,
                    itemBuilder: (context, index) {

                      // FIX: cart item variable নেওয়া হয়েছে
                      final cartItem = cartListController
                          .cartListModel.cartItemList![index];

                      return CartProductItem(

                        // FIX: required named parameter pass করা হয়েছে
                        cartItem: cartItem,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                  ),
                ),
                totalPriceAndCheckOutSection
              ],
            );
          },
        ),
      ),
    );
  }

  Container get totalPriceAndCheckOutSection {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ),
              Text(
                '\$10232930',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Check out'),
            ),
          ),
        ],
      ),
    );
  }
}