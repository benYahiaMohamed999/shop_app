import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/ShopState.dart';
import 'package:test_app/module/Shop_app/home_model.dart';
import 'package:test_app/modules/categories/CategoriesScreen.dart';
import 'package:test_app/modules/favorites/favoritesScreen.dart';
import 'package:test_app/modules/products/products_screen.dart';
import 'package:test_app/modules/settings/settings.dart';
import 'package:test_app/shared/local/remote/dio_helper.dart';
import 'package:test_app/shared/network/end_points.dart';

import '../../../shared/componet/componet.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

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
    emit(ShopChangeBottomNav());
  }

  HomeModel? homeModel;

  getHomeData() {
    emit(ShopLodingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data.banners[0].image);

      printFullText(homeModel.toString());
      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }
}
