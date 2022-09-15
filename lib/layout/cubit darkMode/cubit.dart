import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/cubit%20darkMode/state.dart';

import '../../shared/local/cache_Helper.dart';

class ShopeCubit extends Cubit<ShopState> {
  ShopeCubit() : super(ShopInitialState());

  static ShopeCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  initializeTheme({required bool theme}) {
    isDark = theme;
  }

  Future<void> changeAppMode() async {
    isDark = !isDark;
    CacheHelper.putData(
      key: 'isDark',
      value: isDark,
    ).then((value) {
      emit(AppChangeDarkModeState());
    });
  }
}
