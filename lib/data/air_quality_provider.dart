
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/data/air_quality.dart';

class AQIService {
  
  final String apiKey = "6d4ff6a818ee7323eda40d6d7cf5750317b4e07b";

  Future<AirQuality> fetchAirQuality(String location) async {
  try {
    final url = Uri.parse('https://api.waqi.info/feed/$location/?token=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return AirQuality.fromJson(json.decode(response.body));
    } else {
      throw HttpException(
        'Failed to load air quality data with status code: ${response.statusCode}',
      );
    }
  } on HandshakeException catch (e) {
    // Handle the HandshakeException
    print(e);
    throw Exception('Connection failed during a handshake. Please check your internet connection and try again.');
  }
  
}
Future<void> toggleFavoriteStatus(AirQuality airQuality) async {
    airQuality.isFavorite = !airQuality.isFavorite; // Toggle the current status
    // Update local storage accordingly
    // This might involve reading the current list of favorites, updating it, and writing it back
  }


}