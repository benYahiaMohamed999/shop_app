import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/ShopState.dart';
import 'package:test_app/layout/Shop_layoute/cubit/shopCubit.dart';
import 'package:test_app/module/Shop_app/categories_model.dart';

import '../../shared/componet/componet.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(builder: (context, state) {
      return ListView.separated(
        itemBuilder: (context, index) => buildCatItem(
            ShopCubit.get(context).categoriesModel!.data.data[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
      );
    });
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image,
              ),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_back_ios,
            ),
          ],
        ),
      );
}
