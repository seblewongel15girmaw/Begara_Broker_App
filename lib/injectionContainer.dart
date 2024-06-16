

import 'package:broker_app/core/platform/network_info.dart';
import 'package:broker_app/feauters/auth/data/data_source/broker_data_source.dart';
import 'package:broker_app/feauters/auth/data/repository/broker_repo_impl.dart';
import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:broker_app/feauters/auth/domain/usecases/change_password.dart';
import 'package:broker_app/feauters/auth/domain/usecases/login_broker.dart';
import 'package:broker_app/feauters/auth/domain/usecases/recover_password.dart';
import 'package:broker_app/feauters/auth/domain/usecases/register_broker.dart';
import 'package:broker_app/feauters/auth/domain/usecases/verifyBroker.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/login/login_bloc.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/recover_password/recover_password.dart';
import 'package:broker_app/feauters/auth/presentation/blocs/register/register_bloc.dart';
import 'package:broker_app/feauters/houses/data/data_source/house_data_source.dart';
import 'package:broker_app/feauters/houses/data/repository/house_repository_impl.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:broker_app/feauters/houses/domain/usecases/change_house_status.dart';
import 'package:broker_app/feauters/houses/domain/usecases/delete_house.dart';
import 'package:broker_app/feauters/houses/domain/usecases/get_all_houses.dart';
import 'package:broker_app/feauters/houses/domain/usecases/post_house.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/change_rental_staus/change_rental_staus_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/create_house/create_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/get_house/get_house_bloc.dart';
import 'package:broker_app/feauters/houses/presentation/blocs/remove_house/remove_house_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'feauters/auth/domain/usecases/get_locations.dart';
import 'feauters/auth/presentation/blocs/change_password/change_password.dart';
import 'feauters/auth/presentation/blocs/location/locations.dart';

final sl=GetIt.instance;
Future <void> init() async{
  final sharedPreferences= await SharedPreferences.getInstance();
  sl.registerFactory(() => RegisterBloc(sl(), sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => LocationBloc(sl()));
  sl.registerFactory(() => CreateHouseBloc(sl()));
  sl.registerFactory(() => GetHouseBloc(sl()));
  sl.registerFactory(() => RecoverPasswordBloc(sl()));
  sl.registerFactory(() => ChangePasswordBloc(sl()));
  sl.registerFactory(() => RemoveHouseBloc(deleteHouse: sl()));
  sl.registerFactory(() => ChangeRentalStausBloc(sl()));
  sl.registerLazySingleton(() => RegisterBroker(sl()));
  sl.registerLazySingleton(() => LoginBroker(sl()));
  sl.registerLazySingleton(() => GetLocations(sl()));
  sl.registerLazySingleton(()=> VerifyBroker(sl()));
  sl.registerLazySingleton(() => PostHouse(sl()));
  sl.registerLazySingleton(()=> GetAllHouses(sl()));
  sl.registerLazySingleton(()=> RecoverPassword(sl()));
  sl.registerLazySingleton(()=> ChangePassword(sl()));
  sl.registerLazySingleton(()=> DeleteHouse(houserepository: sl()));
  sl.registerLazySingleton(()=> ChangeHouseStatus(houserepository: sl()));
  sl.registerLazySingleton<BrokerRepo>(() => BrokerRepoImpl(sl(), sl(),) );
  sl.registerLazySingleton<BrokerDataSource>(() => BrokerDataSourceImpl(sl()));
  sl.registerLazySingleton<Houserepository>(() => HouseRepositoryImpl(sl(), sl(),) );
  sl.registerLazySingleton<HouseDataSource>(() => HouseDataSourceImpl(sl()));
  sl.registerLazySingleton<Network>(() => NetworkImpl(sl()));
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

}