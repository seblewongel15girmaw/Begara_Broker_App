import 'package:broker_app/feauters/auth/presentation/blocs/image/id_image.dart/id_image_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/image/profile_image.dart/image.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/location/locations.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/pages/register_page.dart';
import 'package:broker_app/feauters/auth/presentation/pages/verification_screen.dart';
import 'package:broker_app/feauters/houses/domain/entities/house.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_staus_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/pages/home_page.dart';
import 'package:broker_app/feauters/houses/presentation/pages/house_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feauters/auth/presentation/blocs/change_password/change_password.dart';
import '../../feauters/auth/presentation/blocs/recover_password/recover_password.dart';
import '../../feauters/auth/presentation/pages/change_password_page.dart';
import '../../feauters/auth/presentation/pages/forgot_passowrd_page.dart';
import '../../feauters/auth/presentation/pages/login_page.dart';
import '../../feauters/houses/presentation/pages/add_house_page.dart';
import '../../injectionContainer.dart';

class Routes{

  Route<dynamic> generateRoute(RouteSettings settings){
    
    switch(settings.name){
      case '/login':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(create: (context)=>sl<LoginBloc>()),
        BlocProvider<PasswordBloc>(create: (context)=>PasswordBloc()), 
       ],
        child: LoginPage(),
        ),
      );

      case '/register':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<LocationBloc>(create: (context)=>sl<LocationBloc>()),
        BlocProvider<ImageBloc>(create: (context)=>ImageBloc()),
        BlocProvider<RegisterBloc>(create: (context)=>sl<RegisterBloc>()),
        BlocProvider<PasswordBloc>(create: (context)=>PasswordBloc()),
        BlocProvider<IdImageBloc>(create: (context)=>IdImageBloc()),
        
       ],
        child: RegisterPage(),
        ),
      );

      case "/homePage":
        return MaterialPageRoute(builder: (_)=>MultiBlocProvider(
            providers: [
              BlocProvider<LocationBloc>(create: (context)=>sl<LocationBloc>()),
              BlocProvider<ImageBloc>(create: (context)=>ImageBloc()),
              
              BlocProvider<GetHouseBloc>(create: (contex)=>sl<GetHouseBloc>())
            ],
            child: HomePage()));

        case "/houseDetail":
          var args= settings.arguments as House;
        return MaterialPageRoute(builder: (_)=>MultiBlocProvider(
            providers: [
              BlocProvider<LocationBloc>(create: (context)=>sl<LocationBloc>()),
              BlocProvider<ImageBloc>(create: (context)=>ImageBloc()),
              BlocProvider<GetHouseBloc>(create: (contex)=>sl<GetHouseBloc>()),
              BlocProvider<RemoveHouseBloc>(create: (contex)=>sl<RemoveHouseBloc>()),
              BlocProvider<ChangeRentalStausBloc>(create: (contex)=>sl<ChangeRentalStausBloc>(),
              )
            ],
            child: HouseDetail(houseModel: args)));


      case '/add-house':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<ImageBloc>(create: (context)=>ImageBloc()),
        BlocProvider<LocationBloc>(create: (context)=>sl<LocationBloc>()),
        BlocProvider<CreateHouseBloc>(create: (context)=>sl<CreateHouseBloc>()), 
       ],
        child: AddHousePage(),
        ),
      );

      case "/verification":
        return MaterialPageRoute(builder: (_)=>MultiBlocProvider(
            providers: [
              BlocProvider<RegisterBloc>(create: (context)=>sl<RegisterBloc>()),
            ], child: VerificationScreen()));
      case '/forget-password':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<RecoverPasswordBloc>(create: (context)=>sl<RecoverPasswordBloc>()),
       ],
        child: ForgotPasswordPage(),
        ),
      );

      case '/change-password':
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<PasswordBloc>(create: (context)=>PasswordBloc()),
        BlocProvider<ChangePasswordBloc>(create: (context)=>sl<ChangePasswordBloc>()),
       ],
        child: ChangePasswordPage(),
        ),
      );

      default:
      return MaterialPageRoute(
        builder: (_)=>MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(create: (context)=>sl<LoginBloc>()),
        BlocProvider<PasswordBloc>(create: (context)=>PasswordBloc()),
       ],
        child: LoginPage(),
        ),
      );
    }

  }
}