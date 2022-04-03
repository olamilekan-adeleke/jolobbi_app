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
import 'features/food/cubit/food_item_cubit.dart';
import 'features/food/cubit/food_vendor_cubit.dart';
import 'features/food/cubit/vendor_meun_cubit.dart';
import 'features/food/service/food_vendor_service.dart';
import 'features/profile/cubit/user_profile/profile_details_cubit.dart';
import 'features/profile/cubit/user_profile/update_profile_cubit.dart';
import 'features/profile/service/profile_service.dart';

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

  List<BlocProvider> blocList(BuildContext context) {
    return <BlocProvider>[
      BlocProvider<AuthenticatedStateCubit>(
        create: (_) => AuthenticatedStateCubit(
          authStatus: AuthenticatedStatus.unauthenticated,
        ),
        lazy: false,
      ),
      BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(loginRepository: loginRepository),
      ),
      BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(signUpRepository: signUpRepository),
      ),
      BlocProvider<ForgotPasswordCubit>(
        create: (_) => ForgotPasswordCubit(forgotPasswordRepository),
      ),
      BlocProvider<FoodVendorCubit>(
        create: (_) =>
            FoodVendorCubit(foodVendorService)..getPopularFoodVendor(),
      ),
      BlocProvider<FoodItemCubit>(
        create: (_) => FoodItemCubit(foodVendorService)..getFoodItem(),
      ),
      BlocProvider<VendorMenuCubit>(
        create: (_) => VendorMenuCubit(foodVendorService),
      ),
      BlocProvider<ProfileDetailsCubit>(
        create: (_) =>
            ProfileDetailsCubit(profileService)..getCurrentLoginUserData(),
      ),
      BlocProvider<UpdateProfileCubit>(
        create: (_) => UpdateProfileCubit(profileService),
      ),
    ];
  }
}
