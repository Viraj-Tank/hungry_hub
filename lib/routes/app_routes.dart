import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hungry_hub/screens/home/home_screen.dart';
import 'package:hungry_hub/screens/login/login_screen.dart';
import 'package:hungry_hub/screens/order/cart_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const order = '/order';

  static routes() => [
        GetPage(
          name: login,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: home,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: order,
          page: () => const CartScreen(),
        ),
      ];
}
