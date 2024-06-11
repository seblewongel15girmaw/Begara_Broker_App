import 'dart:convert';

import 'package:broker_app/core/error/exceptions.dart';
import 'package:broker_app/feauters/houses/data/utils/function.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/util/sharedPreference.dart';
import '../../../auth/data/utils/function.dart';
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
  Future<List<HouseModel>> getAllHouses(int brokerId) async{
   try{
     List<HouseModel> houseList;
     final token = await SharedPreferencesService.getString("tokens");

  http.Response response = await http.get(Uri.parse(baseUri+"all_broker_house/${1}"));
    List houses= jsonDecode(response.body);
    houseList= houses.map((house) {
     return HouseModel.fromJson(house);
    }).toList();
    print("house list");
     print(houseList);

    return houseList;

   }
   catch(e){
     print("this is the error");
     print(e);
     throw ServerExceptions();
   }
  }

  @override
  Future<House> getHouse(int houseId) async{
    try{
      http.Response res= await http.get(Uri.parse(baseUri+"gethousedetail/:${1}"));
      var house= jsonDecode(res.body);

      HouseModel houseDetail=HouseModel.fromJson(house);
      return houseDetail;
    }
    catch(err){
      print(err);
      throw ServerExceptions();
    }

  }

  @override
  Future<int> postHouse(Location location, double price, int numberOfRoom, String description, List<XFile> images) async{
  final token = await SharedPreferencesService.getString("tokens");
  // final id= decodeJwt(token!)["userId"];
  final apiUrl= Uri.parse(baseUri+"/posthouse/${1}");
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