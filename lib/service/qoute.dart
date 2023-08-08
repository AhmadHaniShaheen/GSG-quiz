// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:api_qize/models/qoute.dart';
import 'package:http/http.dart' as http;

class Qoute {
  Future<Album> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var result = Album.fromJson(jsonDecode(response.body));
      print(result.tag);

      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
