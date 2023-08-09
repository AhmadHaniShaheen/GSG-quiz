// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:api_qize/models/image.dart';
import 'package:http/http.dart' as http;

class ImageProv {
  Future<ImageApi> fetchImage() async {
    final response = await http.get(Uri.parse(
        'https://random.imagecdn.app/v1/image?category=building&format=json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ImageApi.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
