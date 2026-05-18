
import 'package:ecomerce_crafty_bay/data/models/product_model.dart';


//এই class টার কাজ হলো:
// API থেকে আসা JSON data কে Dart object এ convert করা ..
//Dart object কে আবার JSON বানানো। এটাকে বলে: Model Class বা Data Parsing Class

class ProductListModel {//এখানে পুরো product list store হবে।

  String? msg;//Variable Section :: API থেকে একটা message আসবে। String?মানে nullable।value থাকতে পারে আবার null ও হতে পারে।
  List<ProductModel>? productList;//এখানে multiple product store হবে।

  ProductListModel({this.msg, this.productList});//এটা constructor।object create করার সময় value pass করা যায়।

  ProductListModel.fromJson(Map<String, dynamic> json) {//এটা JSON → Dart Object convert করে। Map<String, dynamic> মানে JSON data।
    msg = json['msg'];//Message Parse
    if (json['data'] != null) {//check করছে data আছে কিনা।
      productList = <ProductModel>[];//Empty List Create ..খালি product list বানাচ্ছে।
      json['data'].forEach((v) { //forEach : JSON array এর প্রতিটা item এর উপর loop চালাবে।
        productList!.add(ProductModel.fromJson(v));//Product Object Create //productList! আমি নিশ্চিত এটা null না
      });
    }
  }

  Map<String, dynamic> toJson() { //toJson এখন object → JSON convert করবে।
    final Map<String, dynamic> //মানে একটা JSON map return করবে।
    data = <String, dynamic>{}; //Empty Map Create খালি JSON object।
    data['msg'] = msg;
    if (this.productList != null) { //product list আছে কিনা check করছে।
      data['data'] = this.productList!.map((v) => v.toJson()).toList();
      //map() প্রতিটা product কে convert করবে। toList() সবগুলোকে list বানাবে।
      //fromJson() → parcel খুলে জিনিস সাজায় JSON → Object
      // toJson() → আবার parcel বানায়  Object → JSON
    }
    return data;
  }
}