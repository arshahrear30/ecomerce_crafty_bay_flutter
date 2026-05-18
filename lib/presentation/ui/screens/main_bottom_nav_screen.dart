import 'package:ecomerce_crafty_bay/presentation/ui/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/category_controller.dart';
import '../../state_holders/home_banner_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../utility/app_colours.dart';
import 'auth/new_product_controller.dart';
import 'auth/popular_product_controller.dart';
import 'auth/special_product_controller.dart';
import 'carts_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = const [
    HomeScreen(),//index 0 //ei gula icon er jonno serial//oi icon e click korley ei serial hisebey kaz korbey
    CategoryScreen(),//index 1
    CartsScreen(),//index 2
    WishListScreen(),//index 3
  ];

  @override
  void initState() {
    super.initState();//Home page-এর banner slider/loadable banner data fetch করা।
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<HomeBannerController>().getBannerList();
      //ধরো কোথাও আগে এমন register করা হয়েছে:Get.put(HomeBannerController());তখন Get.find() সেটা খুঁজে পায়।
      Get.find<CategoryController>().getCategoryList();
      //getBannerList  এই method সাধারণত:API call করেdatabase থেকে data আনেbanner list update করেUI refresh করে
      Get.find<PopularProductController>().getPopularProductList();
      Get.find<NewProductController>().getNewProductList();
      Get.find<SpecialProductController>().getSpecialProductList();
    });
  }

  @override   //UI
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) {
        return Scaffold(
          //scaffold er moddey default bottom-navigation-bar thakey .
          // jar karon e nicey home aro button gula bosano jay
          body: _screens[controller.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: controller.changeIndex,
            items: const [

              BottomNavigationBarItem( //index 0
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),

              BottomNavigationBarItem(//index 1
                icon: Icon(Icons.dashboard),
                label: 'Categories',
              ),

              BottomNavigationBarItem(//index 2
                icon: Icon(Icons.shopping_cart),
                label: 'Carts',
              ),

              BottomNavigationBarItem(//index 3
                icon: Icon(Icons.favorite_outlined),
                label: 'Wishlist',
              ),

            ],
          ),
        );
      },
    );
  }
}
