import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/error/errors.dart';

abstract class BrokerRepo {
  Future<Either<Errors, int>> registerBroker(
      String fullName,
      String password,
      String email,
      String phoneNumber,
      String phoneNumber2,
      Location address,
      XFile profilePic,
      XFile idPic,
      String gender);
  
  Future<Either<Errors,String>> loginBroker(String email, String password);
  Future<Either<Errors,List<Location>>> getLocations(String query);
  Future<Either<Errors, String>> verifyBroker(String otp);
}
