import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/admin_users_manager.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:loja_virtual/presentetion/adress/adress_screen.dart';
import 'package:loja_virtual/presentetion/base/base_screen.dart';
import 'package:loja_virtual/presentetion/cart/cart_screen.dart';
import 'package:loja_virtual/presentetion/checkout/checkout_screen.dart';
import 'package:loja_virtual/presentetion/edit_product/edit_product_screen.dart';
import 'package:loja_virtual/presentetion/login/login_screen.dart';
import 'package:loja_virtual/presentetion/product/product_screen.dart';
import 'package:loja_virtual/presentetion/select_product/select_product_screen.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'models/product_manager.dart';
import 'models/user_manager.dart';
import 'presentetion/signup/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager..updateUser(userManager.userModel),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUserManager>(
          create: (_) => AdminUserManager(),
          lazy: false,
          update: (_, userManager, adminUserManager) =>
              adminUserManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'Loja virtual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
              elevation: 0, color: Color.fromARGB(255, 4, 125, 141)),
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen(), settings: settings);
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen(), settings: settings);
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                        product: settings.arguments as ProductModel,
                      ));
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => const CartScreen(), settings: settings);
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) => EditProductScreen(
                  product: settings.arguments as ProductModel,
                ),
              );
            case '/select_product':
              return MaterialPageRoute(
                  builder: (_) => const SelectProductScreen(),
                  settings: settings);
            case '/adress':
              return MaterialPageRoute(
                builder: (_) => const AdressScreen(),
                settings: settings,
              );
            case '/checkout':
              return MaterialPageRoute(
                builder: (_) => const CheckoutScreen(),
                settings: settings,
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => const BaseScreen(), settings: settings);
          }
        },
      ),
    );
  }
}
