import 'package:broker_app/feauters/auth/presentation/blocs/image/image.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/location/locations.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/password_visiblity/password_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/pages/register_page.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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