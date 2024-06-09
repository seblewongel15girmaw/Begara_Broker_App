import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../domain/entities/location.dart';

Future<http.MultipartRequest> uploadSingleImage(
  String fullName,
  String password,
  String email,
  String phoneNumber,
  String phoneNumber2,
  Location address,
  XFile profilePic,
  token,
  apiUrl,
) async {
  final url = Uri.parse(apiUrl);
  final mimeType = lookupMimeType(profilePic.path)!.split('/');
  final imageUploadRequest = http.MultipartRequest('POST', url);
  final file = await http.MultipartFile.fromPath(
    "image",
    profilePic.path,
    contentType: MediaType(mimeType[0], mimeType[1]),
  );
  imageUploadRequest.files.add(file);
  try {
    imageUploadRequest.fields['full_name'] = fullName;
    imageUploadRequest.fields['phone_number1'] = phoneNumber;
    imageUploadRequest.fields['phone_number2'] = phoneNumber2;
    imageUploadRequest.fields['password'] = password;
    imageUploadRequest.fields['email'] = email;
    imageUploadRequest.fields['address'] = jsonEncode(address.toJson());
    imageUploadRequest.headers['Authorization'] = 'Bearer $token';
  } catch (error) {
    print("some error occured $error");
  }
  return imageUploadRequest;
}


Map<String, dynamic> decodeJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }
  final payload = parts[1];
  final String decoded =
  utf8.decode(base64Url.decode(base64Url.normalize(payload)));
  return json.decode(decoded);
}
