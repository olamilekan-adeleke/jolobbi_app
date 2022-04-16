import 'package:flutter/material.dart';

import '../../features/authentication/views/screens/auth_state_screen.dart';
import '../../features/authentication/views/screens/forgot_password.dart';
import '../../features/authentication/views/screens/login_screen.dart';
import '../../features/authentication/views/screens/sign_up_screen.dart';
import '../../features/food/model/food_item_data_model.dart';
import '../../features/food/model/food_vendor_data_model.dart';
import '../../features/cart/views/screens/cart_page.dart';
import '../../features/food/views/screen/favorite/favorite_food_screen.dart';
import '../../features/food/views/screen/food_home_page.dart';
import '../../features/food/views/screen/selcted_food_item_screen.dart';
import '../../features/food/views/screen/vendor/all_food_vendor_screen.dart';
import '../../features/food/views/screen/vendor/selected_vendor_screen.dart';
import '../../features/food/views/screen/vendor/vendor_search_page.dart';
import '../../features/profile/views/screens/address/add_address_page.dart';
import '../../features/profile/views/screens/address/all_address_srceen.dart';
import '../../features/profile/views/screens/profile_screen.dart';
import '../../features/profile/views/screens/update_profile_screen.dart';
import '../../features/profile/views/screens/wallet_pin/confrim_update_wallet_pin_screen.dart';
import '../../features/profile/views/screens/wallet_pin/create_wallet_pin.dart';
import '../../features/profile/views/screens/wallet_pin/update_wallet_pin_screen.dart';
import '../../features/wallet/views/screens/wallet_screen.dart';
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

      case SelectedVendorScreen.route:
        if (args is FoodVendorDataModel) {
          final FoodVendorDataModel foodVendor = args;

          return MaterialPageRoute(
            builder: (_) => SelectedVendorScreen(foodVendor),
          );
        } else {
          return errorRoute();
        }

      case VendorSearchScreen.route:
        return MaterialPageRoute(builder: (_) => const VendorSearchScreen());

      case FavoriteScreen.route:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      case ProfileScreen.route:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case UpdateProfileScreen.route:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());

      case CreateWalletPinPage.route:
        return MaterialPageRoute(builder: (_) => const CreateWalletPinPage());

      case UpdateWalletPinPage.route:
        return MaterialPageRoute(builder: (_) => const UpdateWalletPinPage());

      case ConfirmUpdateWalletPinPage.route:
        return MaterialPageRoute(
          builder: (_) => const ConfirmUpdateWalletPinPage(),
        );

      case AllAddressScreen.route:
        return MaterialPageRoute(builder: (_) => const AllAddressScreen());

      case AddAddressScreen.route:
        return MaterialPageRoute(builder: (_) => const AddAddressScreen());

      case WalletScreen.route:
        return MaterialPageRoute(builder: (_) => const WalletScreen());

      case CartScreen.route:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      default:
        return errorRoute();
    }
  }
}
