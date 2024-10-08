import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/shopCubit.dart';
import 'package:test_app/module/Shop_app/favorites_model.dart';

import '../../layout/Shop_layoute/cubit/ShopState.dart';
import '../../shared/componet/componet.dart';
import '../../shared/style/colors/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! ShopLoadingGetFavoritesState ||
            ShopCubit.get(context).favoritesModel!.data.data != null) {
          return ListView.separated(
            itemBuilder: (context, index) => buildFavIem(
                ShopCubit.get(context).favoritesModel!.data.data[index],
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildFavIem(
    Datum model,
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      model.product.image,
                    ),
                    width: double.infinity,
                    height: 200,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product.price.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.3,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            model.product.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            await ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[model.product.id]!
                                ? Colors.red
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
