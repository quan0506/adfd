// lib/data/model/Place_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Place_model.dart';

class PlaceRepository {
  final String baseUrl = 'http://10.0.2.2:8080/api/places';


  Future<List<Place>> fetchPlaces() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Place.fromJson(json)).toList();
    } else {
      throw Exception('Failed load place');
    }
  }
}
