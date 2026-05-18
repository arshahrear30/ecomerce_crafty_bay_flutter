/*
class PopularProductController extends GetxController {
  bool _newProductInProgress = false;
  bool _popularProductInProgress = false;
  bool _specialProductInProgress = false;
  bool _offerProductInProgress = false;

  bool get newProductInProgress => _newProductInProgress;

  bool get popularProductInProgress => _popularProductInProgress;

  bool get specialProductInProgress => _specialProductInProgress;

  bool get offerroductInProgress => _offerProductInProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  ProductListModel _newProductListModel = ProductListModel();

  ProductListModel _specialProductListModel = ProductListModel();

  ProductListModel _popularProductListModel = ProductListModel();

  ProductListModel _offerProductListModel = ProductListModel();

  ProductListModel get newProductListModel => _newProductListModel;

  ProductListModel get specialProductListModel => _specialProductListModel;

  ProductListModel get popularProductListModel => _popularProductListModel;

  ProductListModel get offerProductListModel => _offerProductListModel;

  Future<bool> getProductListByRemarks(String remarks) async {
    bool isSuccess = false;
    if (remarks == 'new') {
      _newProductInProgress = true;
    } else if (remarks == 'special') {
      _specialProductInProgress = true;
    }  else if (remarks == 'offer') {
      _specialProductInProgress = true;
    } else {
      _popularProductInProgress = true;
    }
    update();
    final response = await NetworkCaller().getRequest(Urls.popularProduct);
    if (remarks == 'new') {
      _newProductInProgress = false;
    } else if (remarks == 'special') {
      _specialProductInProgress = false;
    } else if (remarks == 'offer') {
      _offerProductInProgress = false;
    } else {
      _popularProductInProgress = false;
    }
    if (response.isSuccess) {
      if (remarks == 'new') {
        _newProductListModel = ProductListModel.fromJson(response.responseData);
      } else if (remarks == 'special') {
        _specialProductListModel =
            ProductListModel.fromJson(response.responseData);
      } else if (remarks == 'offer') {
        _offerProductListModel =
            ProductListModel.fromJson(response.responseData);
      } else {
        _popularProductListModel =
            ProductListModel.fromJson(response.responseData);
      }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
*/

import 'package:get/get.dart';

import '../../../../data/models/product_list_model.dart';
import '../../../../data/services/network_caller.dart';
import '../../../../data/utility/urls.dart';

class PopularProductController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;//bool ken use korchi : API call চললে → true ..API শেষ হলে → false

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  ProductListModel _productListModel = ProductListModel();

  ProductListModel get productListModel => _productListModel;

  Future<bool> getPopularProductList() async {//মানে function future এ bool return করবে।যেন screen বুঝতে পারে success না fail।
    bool isSuccess = false;//শুরুতে ধরে নিচ্ছে fail। যদি API success হয় তখন true হবে।
    _inProgress = true;//মানে loading শুরু।
    update();//মানে UI refresh করো।

    final response = await NetworkCaller().getRequest(Urls.popularProduct);//মানে server থেকে data আনছে।
    //networkcaller class e data request sent korcey .. erpor Urls
    _inProgress = false;//API শেষ হলে false


    if (response.isSuccess) {
      _productListModel = ProductListModel.fromJson(response.responseData);//মানে JSON data কে model এ convert করছে।
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }


    update();//মানে UI refresh করো।
    return isSuccess;

  }
}