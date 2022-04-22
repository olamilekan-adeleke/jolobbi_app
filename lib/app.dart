import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/navigator/app_router.dart';
import 'package:sizer/sizer.dart';

import 'cores/constants/color.dart';
import 'cores/navigator/router_generator.dart';
import 'features/authentication/cubits/auth_state_cubit.dart';
import 'features/authentication/cubits/forgot_password/forgot_password_cubit.dart';
import 'features/authentication/cubits/login_cubit/login_cubit.dart';
import 'features/authentication/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'features/authentication/enum/auth_enum.dart';
import 'features/authentication/repository/forgot_password_repository.dart';
import 'features/authentication/repository/login_repository.dart';
import 'features/authentication/repository/sign_up_repositry.dart';
import 'features/authentication/views/screens/auth_state_screen.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/cart/cubit/order_cubit_state.dart';
import 'features/cart/cubit/order_fee_cubit.dart';
import 'features/food/cubit/food_item_cubit.dart';
import 'features/food/cubit/food_vendor_cubit.dart';
import 'features/food/cubit/vendor_meun_cubit.dart';
import 'features/food/service/food_vendor_service.dart';
import 'features/profile/cubit/address_cubit/update_address_cubit.dart';
import 'features/profile/cubit/user_profile/profile_details_cubit.dart';
import 'features/profile/cubit/user_profile/update_profile_cubit.dart';
import 'features/profile/cubit/wallet_pin/update_wallet_pin_cubit.dart';
import 'features/profile/service/profile_service.dart';
import 'features/profile/service/update_wallet_service.dart';
import 'features/profile/service/wallet_service.dart';
import 'features/wallet/cubit/fund_wallet_cubit.dart';
import 'features/wallet/cubit/send_fund_cubit.dart';
import 'features/wallet/cubit/transaction_history_cubit.dart';
import 'features/wallet/cubit/wallet_cubit.dart';

class JolobbiApp extends StatelessWidget {
  const JolobbiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _BlocProviderHelper().blocList(context),
      child: Sizer(
        builder: (_, __, ___) {
          return MaterialApp(
            title: 'Jolobbi Dev',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              primaryColor: kcPrimaryColor,
              errorColor: kcErrorColor,
            ),
            initialRoute: AuthStateScreen.route,
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: AppRouter.instance.navigatorKey,
          );
        },
      ),
    );
  }
}

class _BlocProviderHelper {
  static final LoginRepository loginRepository = LoginRepository();
  static final SignUpRepository signUpRepository = SignUpRepository();
  static final ForgotPasswordRepository forgotPasswordRepository =
      ForgotPasswordRepository();
  static final FoodVendorService foodVendorService = FoodVendorService();
  static final ProfileService profileService = ProfileService();
  static final WalletPinService walletPinService = WalletPinService();
  static final UpdateAddressService updateAddressService =
      UpdateAddressService();

  List<BlocProvider> blocList(BuildContext context) {
    return <BlocProvider>[
      BlocProvider<AuthenticatedStateCubit>(
        create: (context) => AuthenticatedStateCubit(
          authStatus: AuthenticatedStatus.unauthenticated,
        ),
        lazy: false,
      ),
      BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(loginRepository: loginRepository),
      ),
      BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(signUpRepository: signUpRepository),
      ),
      BlocProvider<ForgotPasswordCubit>(
        create: (context) => ForgotPasswordCubit(forgotPasswordRepository),
      ),
      BlocProvider<FoodVendorCubit>(
        create: (context) =>
            FoodVendorCubit(foodVendorService)..getPopularFoodVendor(),
      ),
      BlocProvider<FoodItemCubit>(
        create: (context) => FoodItemCubit(foodVendorService)
          ..getFoodItem()
          ..getSnackItem()
          ..getDrinkItem(),
      ),
      BlocProvider<VendorMenuCubit>(
        create: (context) => VendorMenuCubit(foodVendorService),
      ),
      BlocProvider<ProfileDetailsCubit>(
        create: (context) =>
            ProfileDetailsCubit(profileService)..getCurrentLoginUserData(),
        lazy: false,
      ),
      BlocProvider<UpdateProfileCubit>(
        create: (context) => UpdateProfileCubit(profileService),
      ),
      BlocProvider<UpdateWalletPinCubit>(
        create: (context) => UpdateWalletPinCubit(walletPinService),
      ),
      BlocProvider<UpdateAddressCubit>(
        create: (context) => UpdateAddressCubit(updateAddressService),
      ),
      BlocProvider<WalletCubit>(
        create: (context) => WalletCubit()..getWalletBalance(),
      ),
      BlocProvider<FundWalletCubit>(create: (context) => FundWalletCubit()),
      BlocProvider<CartCubit>(create: (context) => CartCubit()),
      BlocProvider<OrderFeeCubit>(
          create: (context) => OrderFeeCubit()..getFee()),
      BlocProvider<SendFundCubit>(create: (context) => SendFundCubit()),
      BlocProvider<TransactionHistoryCubit>(
        create: (context) =>
            TransactionHistoryCubit()..getUserTransactionHistory(),
      ),
      BlocProvider<AddOrderCubit>(create: (context) => AddOrderCubit()),
    ];
  }
}
