

import 'package:broker_app/core/platform/network_info.dart';
import 'package:broker_app/feauters/auth/data/data_source/broker_data_source.dart';
import 'package:broker_app/feauters/auth/data/repository/broker_repo_impl.dart';
import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:broker_app/feauters/auth/domain/usecases/login_broker.dart';
import 'package:broker_app/feauters/auth/domain/usecases/register_broker.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_bloc.dart';
import 'package:broker_app/feauters/houses/data/data_source/house_data_source.dart';
import 'package:broker_app/feauters/houses/data/repository/house_repository_impl.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:broker_app/feauters/houses/domain/usecases/post_house.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'feauters/auth/domain/usecases/get_locations.dart';
import 'feauters/auth/presentation/blocs/location/locations.dart';

final sl=GetIt.instance;
Future <void> init() async{
  final sharedPreferences= await SharedPreferences.getInstance();
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => LocationBloc(sl()));
  sl.registerFactory(() => CreateHouseBloc(sl()));
  sl.registerLazySingleton(() => RegisterBroker(sl()));
  sl.registerLazySingleton(() => LoginBroker(sl()));
  sl.registerLazySingleton(() => GetLocations(sl()));
  sl.registerLazySingleton(() => PostHouse(sl()));
  sl.registerLazySingleton<BrokerRepo>(() => BrokerRepoImpl(sl(), sl(),) );
  sl.registerLazySingleton<BrokerDataSource>(() => BrokerDataSourceImpl(sl()));
  sl.registerLazySingleton<Houserepository>(() => HouseRepositoryImpl(sl(), sl(),) );
  sl.registerLazySingleton<HouseDataSource>(() => HouseDataSourceImpl(sl()));
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

}