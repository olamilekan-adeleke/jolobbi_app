import 'package:flutter/material.dart';

import '../../features/authentication/views/screens/auth_state_screen.dart';
import '../../features/authentication/views/screens/forgot_password.dart';
import '../../features/authentication/views/screens/login_screen.dart';
import '../../features/authentication/views/screens/sign_up_screen.dart';
import '../../features/food/model/food_item_data_model.dart';
import '../../features/food/views/screen/food_home_page.dart';
import '../../features/food/views/screen/selcted_food_item_screen.dart';
import '../../features/food/views/screen/vendor/all_food_vendor_screen.dart';
import 'error_route_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case AuthStateScreen.route:
        return MaterialPageRoute(builder: (_) => const AuthStateScreen());
      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case SignUpScreen.route:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case ForgotPasswordScreen.route:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case FoodHomePage.route:
        return MaterialPageRoute(builder: (_) => const FoodHomePage());
      case SelectedFoodItemWidget.route:
        if (args is FoodItemDataModel) {
          final FoodItemDataModel foodItem = args;
          return MaterialPageRoute(
            builder: (_) => SelectedFoodItemWidget(foodItem),
          );
        } else {
          return errorRoute();
        }
      case AllFoodVendorScreen.route:
        return MaterialPageRoute(builder: (_) => const AllFoodVendorScreen());

      // case '/second':
      //   // Validation of correct data type
      //   if (args is String) {
      //     return MaterialPageRoute(
      //       builder: (_) => SecondPage(data: args),
      //     );
      //   }

      default:
        return errorRoute();
    }
  }
}
