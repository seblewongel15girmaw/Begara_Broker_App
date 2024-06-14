import 'dart:convert';

import 'package:broker_app/core/error/exceptions.dart';
import 'package:broker_app/feauters/auth/data/utils/function.dart';
import 'package:broker_app/feauters/auth/domain/entities/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../core/util/sharedPreference.dart';
import '../model/location.dart';

abstract class BrokerDataSource {
  Future<int> registerBroker(
      String fullName,
      String password,
      String email,
      String phoneNumber,
      String phoneNumber2,
      Location address,
      XFile profilePic,
      XFile idPic,
      String gender,
      );

  Future<String> loginBroker(String email, String password);
  Future<List<LocationModel>> getLocations(String query);
  Future<String> verifyBroker(String otp);
}

class BrokerDataSourceImpl implements BrokerDataSource {
  final baseUri = "http://localhost:3000/api/brokers/";
  final http.Client client;
  BrokerDataSourceImpl(this.client);
  @override
  Future<String> loginBroker(String email, String password) async {
    final response = await client.post(Uri.parse(baseUri + "login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];
      SharedPreferencesService.setString("tokens", token);
      return token;
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<int> registerBroker(
      String fullName,
      String password,
      String email,
      String phoneNumber,
      String phoneNumber2,
      Location address,
      XFile profilePic,
      XFile idPic,
      String gender) async {
    final token = await SharedPreferencesService.getString("tokens");
    final request = await uploadSingleImage(
        fullName,
        password,
        email,
        phoneNumber,
        phoneNumber2,
        address,
        profilePic,
        idPic,
        gender,
        token,
        baseUri + "signup");
    final response = await request.send();
    print("this is signup");
    if (response.statusCode == 200) {
      var responseResult = await http.Response.fromStream(response);
      final jsonResponse = json.decode(responseResult.body);
      print(jsonResponse);
      final session = jsonResponse['sessionId'];
      await SharedPreferencesService.setString("session",session );
      return response.statusCode;
    } else {
      throw ServerExceptions();
    }
  }
  
  @override
  Future<List<LocationModel>> getLocations(String query) async{
    final String _baseUrl = 'https://nominatim.openstreetmap.org/search';
   final response = await  client.get(
      Uri.parse('$_baseUrl?q=$query&format=json&addressdetails=1&countrycodes=et'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => LocationModel.fromJson(item)).toList();
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<String> verifyBroker(String otp) async{
    var sessionId= await SharedPreferencesService.getString("session");
   try{
     var res= await client.post(
         Uri.parse(baseUri+"verify"),
         headers: {
           'Content-Type': 'application/json; charset=UTF-8',
         },
         body: jsonEncode({
           "sessionId": sessionId,
           "verificationCode": otp,
         }));
     if(res.statusCode ==200){
       print(jsonDecode(res.body)["token"]);
       return jsonDecode(res.body);
     }
     else{
       throw ServerExceptions();
     }
   }
       catch(err){
         throw ServerExceptions();
       }
  }
}
