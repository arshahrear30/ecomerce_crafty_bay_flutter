import 'package:ecomerce_crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/category_controller.dart';
import '../../state_holders/home_banner_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../utility/assets_path.dart';
import '../widgets/category_item.dart';
import '../widgets/center_circular_progress_indicator.dart';
import '../widgets/home/banner_carousel.dart';
import '../widgets/home/circle_icon_button.dart';
import '../widgets/home/section_title.dart';
import '../widgets/product_card_item.dart';
import 'auth/new_product_controller.dart';
import 'auth/popular_product_controller.dart';
import 'auth/special_product_controller.dart';
import 'auth/verify_email_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: appBar,
      body: SingleChildScrollView( //কারণ home page-এ অনেক content আছে //ebong jodi keybord on hoy tailey screen bangbey na
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),//symmetric মানে: দুই পাশ সমান হবে।left  = 16 right = 16
          child: Column(
            children: [
              const SizedBox(height: 8,),

              searchTextField, //এটা search box দেখাচ্ছে। //nicey call dici but sobar upor e dekanor serial maintain ui er jonno ei khan e likchi

              const SizedBox(height: 16,),


              SizedBox(
                height: 210,
                child: GetBuilder<HomeBannerController>( //এখানে GetX দিয়ে banner data observe করছে।
                    builder: (homeBannerController) {
                      return Visibility(//Loading check
                        visible: homeBannerController.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),//যদি data loading হয়: tailey replacement use hoibo

                        child: BannerCarousel(//data ready হলে:
                          bannerList:
                          homeBannerController.bannerListModel.bannerList ?? [],//??[] dicey karon: null safety , app crash prevent করা,widget-কে সবসময় একটা list দেওয়া
                          //?? ->  যদি বাম পাশের value null হয়, তাহলে ডান পাশের value use করো।
                          //[] -> empty list

                        ),


                      );
                    }),
              ),


              const SizedBox(height: 16,),


              SectionTitle(
                title: 'All Categories',
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1); //main_bottom_nav_controller e ekta class changeIndex
                },
              ),


              categoryList,
              SectionTitle(
                title: 'Popular',

                onTapSeeAll: () {
                  Get.to(() => const ProductListScreen());
                },

              ),
              GetBuilder<PopularProductController>(
                  builder: (popularProductController) {
                    return Visibility(
                      visible: popularProductController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),

                      child: productList(
                          popularProductController.productListModel.productList ?? []),

                    );
                  }),



              const SizedBox(height: 8,),


              SectionTitle(//same as popular
                title: 'Special',
                onTapSeeAll: () {},
              ),
              GetBuilder<SpecialProductController>(
                  builder: (specialProductController) {
                    return Visibility(
                      visible: specialProductController.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: productList(
                          specialProductController.productListModel.productList ??
                              []),
                    );
                  }),


              const SizedBox(
                height: 8,
              ),




              SectionTitle(//same as popular
                title: 'New',
                onTapSeeAll: () {},
              ),
              GetBuilder<NewProductController>(builder: (newProductController) {
                return Visibility(
                  visible: newProductController.inProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: productList(
                      newProductController.productListModel.productList ?? []),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }


  SizedBox get categoryList {
    return SizedBox(
      height: 130,//category section er height 130 fixed
      child: GetBuilder<CategoryController>(
          builder: (categoryController) {
            return Visibility(
              visible: categoryController.inProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: ListView.separated(//list item গুলা show করা + item গুলার মাঝে gap/divider দেওয়া।
                itemCount: categoryController.categoryListModel.categoryList?.length ?? 0,//?? koita acey .. nul hoiley 0 .
                primary: false,//এই scrollable widget কি screen-এর main scroll controller use করবে?তুমি false দিয়েছ, মানে:এই ListView main scroll না, নিজের মতো scroll করবে।
                shrinkWrap: true,//যতটুকু content আছে, ListView ঠিক ততটুকু size নিবে। shrinkWrap: true না দিলে অনেক সময় error আসে: karon beshi jayga niya UI nosto koira  feley
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryItem(
                      category: categoryController.categoryListModel
                          .categoryList![index]); //last e ! deyar maney আমি নিশ্চিত এটা null না
                },
                separatorBuilder: (_, __) { //separatorBuilder: (_, __) { //Normally Flutter এ এমন হয়:(context, index)
                  // কিন্তু এখানে parameters দরকার নেই।তাই ignore করার জন্য _ ব্যবহার করেছে।Flutter parameter পাঠাচ্ছে, কিন্তু আমি use করছি না।
                  return const SizedBox( //প্রতি দুই item-এর মাঝে gap 8 koira
                    width: 8,
                  );
                },
              ),
            );
          }
      ),
    );
  }

  SizedBox productList(List<ProductModel> productList) { //এটা একটা reusable function.. যেকোন product list pass করলে UI বানাবে।
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: productList.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCardItem(
            product: productList[index],
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  TextFormField get searchTextField { //search icon

    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,//background থাকবে
        fillColor: Colors.grey.shade200, //bg colour grey dici

        prefixIcon: const Icon( //search box er suru tey search icon
          Icons.search,
          color: Colors.grey,
        ),



        border: OutlineInputBorder(//default/অন্য specific border না পেলে এটা use হবে।
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(//normal অবস্থায়--যখন TextField:active আছে -- user click করে নাই
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(//click/typing অবস্থায় user //textbox-এ click করেছে //keyboard open হয়েছে// typing করছে // মানে focus state।
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),

        //border,enabledBorder,focusedBorder তিনটাতেই same design দেওয়া হয়েছে

      ),
    );
  }




  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () async {
            await Get.find<AuthController>().clearAuthData();
            Get.offAll(() => const VerifyEmailScreen()); //নতুন screen-এ যাও + আগের সব screen remove করে দাও। সব previous page remove করো, তারপর নতুন page open করো
            // Get.to()	নতুন page push করে // Get.off()	current page remove করে next page //Get.offAll()	সব page remove করে next page
          },
          iconData: Icons.person,
        ),
        const SizedBox(width: 8,),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.call,
        ),
        const SizedBox(width: 8,),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
      ],
    );
  }
}