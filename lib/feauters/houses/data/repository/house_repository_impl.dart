import 'package:broker_app/core/error/errors.dart';
import 'package:broker_app/core/error/exceptions.dart';
import 'package:broker_app/core/platform/network_info.dart';
import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:broker_app/feauters/houses/data/data_source/house_data_source.dart';
import 'package:broker_app/feauters/houses/domain/entities/house.dart';
import 'package:broker_app/feauters/houses/domain/repository/houseRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class HouseRepositoryImpl implements Houserepository{
  HouseDataSource houseDataSource;
  Network network;
  HouseRepositoryImpl(this.houseDataSource,this.network);
  @override
  Future<Either<Errors, List<House>>> getAllHouses(int brokerId) async{
    try{
      network.isConnected;
      return Right(await houseDataSource.getAllHouses(brokerId));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

  @override
  Future<Either<Errors, House>> getHouse(int houseId) async{
    try{
      network.isConnected;
      return Right(await houseDataSource.getHouse(houseId));
    }
    on ServerExceptions{
    return Left(ServerErrors());
    }
  }

  @override
  Future<Either<Errors, int>> postHouse(Location location, double price, int numberOfRoom, String description, List<XFile> images) async{
    try{
      network.isConnected;
      return Right(await houseDataSource.postHouse(location, price, numberOfRoom, description, images));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, int>> changeHouseStatus(int houseId) async{
    try{
      network.isConnected;
      return Right(await houseDataSource.changeHouseStatus(houseId));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }
  
  @override
  Future<Either<Errors, int>> deleteHouse(int houseId) async{
    try{
      network.isConnected;
      return Right(await houseDataSource.deleteHouse(houseId));
    }
    on ServerExceptions{
      return Left(ServerErrors());
    }
  }

}