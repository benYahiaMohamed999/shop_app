import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/ShopState.dart';
import 'package:test_app/layout/Shop_layoute/cubit/shopCubit.dart';
import 'package:test_app/modules/search/searchScreen.dart';
import 'package:test_app/shared/componet/componet.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Ennour'),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: cubit.bottomScreens[cubit.currenIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currenIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
