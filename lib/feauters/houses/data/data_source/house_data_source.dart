import 'package:broker_app/core/error/exceptions.dart';
import 'package:broker_app/feauters/houses/data/utils/function.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/util/sharedPreference.dart';
import '../../../auth/domain/entities/location.dart';
import '../../domain/entities/house.dart';
import '../model/house_model.dart';
import 'package:http/http.dart' as http;
abstract class HouseDataSource{
  Future<int> postHouse(Location location, double price, int numberOfRoom, String description, List<XFile> images);
  Future<List<HouseModel>> getAllHouses(int brokerId);
  Future<House> getHouse(int houseId);
}

class HouseDataSourceImpl implements HouseDataSource{
  final baseUri= "http://localhost:3000/api/houses/";
  final http.Client client;
  HouseDataSourceImpl(this.client);
  @override
  Future<List<HouseModel>> getAllHouses(int brokerId) {
    // TODO: implement getAllHouses
    throw UnimplementedError();
  }

  @override
  Future<House> getHouse(int houseId) {
    // TODO: implement getHouse
    throw UnimplementedError();
  }

  @override
  Future<int> postHouse(Location location, double price, int numberOfRoom, String description, List<XFile> images) async{
  final token = await SharedPreferencesService.getString("tokens");
  final apiUrl= Uri.parse(baseUri+"/posthouse");
   final request= await uploadMultipleImage(location, price, numberOfRoom, description, images, token, apiUrl);
   final response= await request.send();
   if(response.statusCode==201){
    return response.statusCode;
   }
   else{
    throw ServerExceptions();
   }
  }

}