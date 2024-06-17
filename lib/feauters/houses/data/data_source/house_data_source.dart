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
  Future<int> deleteHouse(int houseId);
  Future<int> changeHouseStatus(int houseId);
  Future<int> editHouse(int houseId,Location location, double price, int numberOfRoom, String description,List<XFile>images);
}

class HouseDataSourceImpl implements HouseDataSource{
  final baseUri= "http://localhost:3000/api/houses/";
  final http.Client client;
  HouseDataSourceImpl(this.client);

  @override
  Future<List<HouseModel>> getAllHouses(int brokerId) async{
     List<HouseModel> houseList;
     final token = await SharedPreferencesService.getString("tokens");  
     final brokerId= decodeJwt(token!)["brokerId"]; 
  http.Response response = await http.get(Uri.parse(baseUri+"all_broker_house/${brokerId}"),
  headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },);

    if(response.statusCode==200){
    List houses= jsonDecode(response.body);
    print(response.body);
    houseList= houses.map((house) {
     return HouseModel.fromJson(house);
    }).toList();
    print("house list");
    print(houseList);
    return houseList;}
   else{
    
     print("this is the error ${response.body}");
     throw ServerExceptions();
   }
  }

  @override
  Future<House> getHouse(int houseId) async{
    try{
      final token = await SharedPreferencesService.getString("tokens");  
      final brokerId= decodeJwt(token!)["brokerId"];
      http.Response res= await http.get(Uri.parse(baseUri+"gethousedetail/:${brokerId}"));
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
  final brokerId= decodeJwt(token!)["brokerId"];
  
  // final id= decodeJwt(token!)["userId"];
  final apiUrl= Uri.parse(baseUri+"/posthouse/${brokerId}");
   final request= await uploadMultipleImage(location, price, numberOfRoom, description, images, token, apiUrl,"POST");
   final response= await request.send();
   if(response.statusCode==201){
    return response.statusCode;
   }
   else{
    throw ServerExceptions();
   }
  }
  
  @override
  Future<int> changeHouseStatus(int houseId) async{
   final token = await SharedPreferencesService.getString("tokens");
   final response= await client.post(Uri.parse(baseUri+"house_status/${houseId}"),
   headers:{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }, );
    if(response.statusCode==200){
      return response.statusCode;
    }
    else{
      throw ServerExceptions();
    }
  }
  
  @override
  Future<int> deleteHouse(int houseId) async{
    final token = await SharedPreferencesService.getString("tokens");
   final response= await client.delete(Uri.parse(baseUri+"deletehouse/${houseId}"),
   headers:{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }, );
    if(response.statusCode==201){
      return response.statusCode;
    }
    else{
      print(response.body);
      throw ServerExceptions();
    }
  }
  
  @override
  Future<int> editHouse(int houseId, Location location, double price, int numberOfRoom, String description, List<XFile> images) async{
    final token = await SharedPreferencesService.getString("tokens"); 
    final apiUrl= Uri.parse(baseUri+"/edithouse/${houseId}");
   final request= await uploadMultipleImage(location, price, numberOfRoom, description, images, token, apiUrl,"PUT");
   final response= await request.send();
   if(response.statusCode==201){
    return response.statusCode;
   }
   else{
    throw ServerExceptions();
   }

  }

}