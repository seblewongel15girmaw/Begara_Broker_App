import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/error/exceptions.dart';
import 'package:broker_app/core/platform/network_info.dart';
import 'package:broker_app/feauters/auth/data/data_source/broker_data_source.dart';
import 'package:broker_app/feauters/auth/domain/repository/broker_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/location.dart';

class BrokerRepoImpl implements BrokerRepo{
  BrokerDataSource brokerDataSource;
  Network network;
  BrokerRepoImpl(this.brokerDataSource, this.network);
  @override
  Future<Either<Errors, String>> loginBroker(String email, String password) async{
    try{
      network.isConnected;
      return Right(await brokerDataSource.loginBroker(email, password));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
    
  }

  @override
  Future<Either<Errors, int>> registerBroker(String fullName, String password, String email, String phoneNumber, String phoneNumber2, Location address, XFile profilePic,XFile idPic,String gender) async{
    try{
      network.isConnected;
      return Right(await brokerDataSource.registerBroker(fullName, password, email, phoneNumber, phoneNumber2, address, profilePic,idPic,gender));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, List<Location>>> getLocations(String query) async{
    try{
      network.isConnected;
      return Right(await brokerDataSource.getLocations(query));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

}