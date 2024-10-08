import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/layout/Shop_layoute/cubit/ShopState.dart';
import 'package:test_app/layout/Shop_layoute/cubit/shopCubit.dart';
import 'package:test_app/shared/componet/componet.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).usermodel!;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).usermodel != null,
          builder: (context) => profile(context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget profile(context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'name must not be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
                prefix: Icon(
                  Icons.person,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email must not be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('E-mail'),
                prefix: Icon(
                  Icons.email,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'phone must not be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Phone'),
                prefix: Icon(
                  Icons.phone,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.amber, //
              ),
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {
                  signOut(context);
                },
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
