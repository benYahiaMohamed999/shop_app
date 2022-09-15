import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/ShopState.dart';
import 'package:test_app/module/Shop_app/categories_model.dart';
import 'package:test_app/module/Shop_app/favorites_model.dart';
import 'package:test_app/module/Shop_app/home_model.dart';
import 'package:test_app/modules/categories/CategoriesScreen.dart';
import 'package:test_app/modules/favorites/favoritesScreen.dart';
import 'package:test_app/modules/products/products_screen.dart';
import 'package:test_app/modules/settings/settings.dart';
import 'package:test_app/shared/local/remote/dio_helper.dart';
import 'package:test_app/shared/network/end_points.dart';

import '../../../module/Shop_app/change_Favorites_model.dart';
import '../../../shared/componet/componet.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(Data) : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currenIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategorieScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index) {
    currenIndex = index;
    if (index == 2) {
      getFavorites();
    }
    emit(ShopChangeBottomNav());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  getHomeData() {
    emit(ShopLodingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data.banners[0].image);
      printFullText(homeModel.toString());
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites);

      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  getCategories() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel?.fromJson(value.data);

      emit(ShopSuccesCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  changeFavorites(int productId) async {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId]!;
      }
      emit(ShopSuccesChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  Future<void> getFavorites() async {
    emit(ShopLoadingGetFavoritesState());

    await DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccesGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }
}
