import 'package:test_app/module/Shop_app/change_Favorites_model.dart';
import 'package:test_app/module/Shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNav extends ShopStates {}

class ShopLodingHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccesHomeDataState extends ShopStates {}

class ShopSuccesCategoriesState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccesChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccesChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {
  final error;

  ShopErrorChangeFavoritesState(this.error);
}

// GET FAVORITES
class ShopSuccesGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopSuccesLoginState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccesLoginState(this.loginModel);
}

class ShopLoadingLoginState extends ShopStates {}

class ShopErrorLoginState extends ShopStates {
  final Error;

  ShopErrorLoginState(this.Error);
}
