import 'package:flutter/foundation.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:shopping_app/provider/products.dart';
import 'package:shopping_app/provider/cart.dart';
import 'package:shopping_app/screens/allproduct_screen.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';
import 'package:shopping_app/screens/order_screen.dart';
import 'package:shopping_app/screens/productdetail_screen.dart';
import 'package:shopping_app/screens/user_screen.dart';
import 'package:shopping_app/screens/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/provider/order.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shopping_app/screens/order_info.dart';

void main() {
  runApp(
    MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MultiProvider(
        providers: [

          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider(
            create: (context) => Products(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          ),

        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
                home: auth.isAuth ? Allproduct() : WelcomeScreen(),
                routes: {
                  Productdetail.routName: (ctx) => Productdetail(),
                  CartScreen.routeName: (ctx) => CartScreen(),
                  OrdersScreen.routeName: (ctx) => OrdersScreen(),
                  Allproduct.routeName: (ctx) => Allproduct(),
                  UserProductsScreen.routeName: (ctx) =>
                      UserProductsScreen(),
                  OrderInfo.routeName:(ctx)=>OrderInfo(),
                  EditProductScreen.routeName: (ctx) => EditProductScreen(),
                })));
  }
}
