import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import '../../../auth/domain/entities/location.dart';

Future<http.MultipartRequest> uploadMultipleImage(
  Location location,
  double price,
  int numberOfRoom,
  String description,
  List<XFile> images,
  token,
  apiUrl,
) async {
  final imageUploadRequest = http.MultipartRequest('POST', apiUrl);
  for (var profilePic in images) {
    final mimeType = lookupMimeType(profilePic.path)!.split('/');
    final file = await http.MultipartFile.fromPath(
      'images',
      profilePic.path,
      contentType: MediaType(mimeType[0], mimeType[1]),
    );
    imageUploadRequest.files.add(file);
  }
  try {
    imageUploadRequest.fields['location'] = jsonEncode(location.toJson());
    imageUploadRequest.fields['price'] = price.toString();
    imageUploadRequest.fields['numberOfRoom'] = numberOfRoom.toString();
    imageUploadRequest.fields['description'] = description;
    imageUploadRequest.headers['Authorization'] = 'Bearer $token';
  } catch (error) {
    print("some error occured $error");
  }
  return imageUploadRequest;
}
