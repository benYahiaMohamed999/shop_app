import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/shopCubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_app/module/Shop_app/home_model.dart';
import 'package:test_app/shared/componet/componet.dart';
import 'package:test_app/shared/style/colors/colors.dart';
import '../../layout/Shop_layoute/cubit/ShopState.dart';
import '../../module/Shop_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccesChangeFavoritesState) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: ToastStates.ERROR);
          } else {
            showToast(text: state.model.message, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        if (ShopCubit.get(context).homeModel == null ||
            ShopCubit.get(context).categoriesModel == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return builderWidget(ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!, context);
        }
      },
    );
  }
}

Widget builderWidget(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map((e) => Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 5),
                              blurRadius: 11,
                            )
                          ]),
                      child: Image(
                        image: NetworkImage(
                          '${e.image}',
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.antiAlias,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoriesItem(
                        categoriesModel.data.data[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10,
                    ),
                    itemCount: categoriesModel.data.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[300],
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.65,
              children: List.generate(
                model.data.products.length,
                (index) => buildProduct(model.data.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildCategoriesItem(DataModel model, context) => Container(
      height: 100,
      width: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          if (model.image != null)
            Image(
              image: NetworkImage(model.image),
              //wselt
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

Widget buildProduct(ProductModel model, context) => Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 80,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image,
                    ),
                    width: double.infinity,
                    height: 200,
                  ),
                  if (model.discount != 0)
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
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}€',
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}€',
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
                              .changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
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
