import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/on_bording/login/loginScreen.dart';
import '../local/cache_Helper.dart';

Widget buildArticlItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, Widget //WebViewScreen(article.url!),
            );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: article.urlToImage == null
                      ? const NetworkImage(
                          'https://www.middleweb.com/wp-content/uploads/2017/08/breaking-news-blue-600.jpg',
                        )
                      : NetworkImage(
                          article.urlToImage!,
                        ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        article.title!,
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      article.publishedAt!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articalBulder(List list, context, {isSearch = false}) =>
    ConditionalBuilder(
      builder: (context) => ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, int index) =>
            buildArticlItem(list[index], context),
        itemCount: list.length,
        physics: const BouncingScrollPhysics(),
      ),
      condition: true, //NewsCubit.get(context).business != null

      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

//COLORS
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum≠≠
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinsh(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Widget,
      ),
      (Route<dynamic> route) => false,
    );
void showTost({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColors(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color? ChooseToastColors(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;

      break;
    case ToastState.ERROR:
      color = Colors.red;

      break;
    case ToastState.WARNING:
      color = Colors.amber;

      break;
      return color;
  }
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value!) {
      navigateAndFinsh(
        context,
        LoginScrren(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunck
  pattern.allMatches(text).forEach(
        (match) => print(match.group(0)),
      );
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

String? token =
    'gJO8UGjCvKrFAepNX7etq7FWkTVPAYsdNDmMruaqsDfQcpLVjKSXpni1C6tQOGTrH4Elxd';
