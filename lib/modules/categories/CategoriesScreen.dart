import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Categorie Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
