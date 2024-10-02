import 'dart:convert';
import 'package:exo3/models/breed.dart';
import 'package:http/http.dart' as http;

class StatusErrorException {
  final int statusCode;

  const StatusErrorException(this.statusCode);
}

class CatApi {
  static const apiLink = 'api.thecatapi.com';
  static const apiUrl = 'v1';
  static const searchRoute = '$apiUrl/breeds';
  static const apiKey =
      'live_Zw0Oscm9zYQKqiuQEP1eONSmEdPlXxvIOxADxrVzNL2CpC20dfhUfehMXzGJgvFk';
  static const apiKeyHeader = 'x-api-key';
  static const headers = {apiKeyHeader : apiKey};

  Future<List<Breed>> breeds() async {
    var result = await http.get(Uri.https(apiLink, searchRoute), headers: headers);
    if (result.statusCode == 200) {
      final List<dynamic> datas = jsonDecode(result.body);
      return datas.map((e) => Breed.fromMap(e)).toList();
    }
    throw StatusErrorException(result.statusCode);
  }
}
