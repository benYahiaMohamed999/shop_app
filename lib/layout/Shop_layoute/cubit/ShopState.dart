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

class ShopErrorCategoriesState extends ShopStates {
  final error;

  ShopErrorCategoriesState(this.error);
}
