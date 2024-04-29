import 'package:flutter_application_1/src/api/api_repository.dart';
import 'package:flutter_application_1/src/model/current_weather_data.dart';
import 'package:flutter_application_1/src/model/five_.dart';

class WeatherService {
  final String city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=eb08d9dba8ccfdaa174fd19d87efff05';

  WeatherService({required this.city});

  void getCurrentWeatherData({
    Function()? beforeSend, // Corrected spelling and made nullable
    required Function(CurrentWeatherData currentWeatherData) onSuccess,
    required Function(dynamic error) onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    ApiRepository(url: url, payload: {}).get( // Made payload an empty map if it's necessary
      beforeSend: beforeSend, // Simplified callback invocation
      onSuccess: (data) => onSuccess(CurrentWeatherData.fromJson(data)),
      onError: onError, // Simplified callback invocation
    );
  }
  

  void getFiveDaysThreeHoursForecastData({
    Function()? beforeSend,
    required Function(List<FiveDayData> fiveDayData) onSuccess,
    required Function(dynamic error) onError,
}) {
  final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';

  // Optionally call beforeSend if provided
  beforeSend?.call();

  // Perform the API call
  ApiRepository(url: url, payload: {}).get(
    onSuccess: (data) {
      try {
        // Attempt to parse the data
        if (data['list'] != null) {
          List<dynamic> dataList = data['list'];
          List<FiveDayData> forecastData = dataList.map((item) {
            return FiveDayData.fromJson(item);
          }).toList();
          onSuccess(forecastData);
        } else {
          // Handle the case where 'list' is missing in the response
          throw FormatException("Missing 'list' key in response data");
        }
      } catch (e) {
        // Handle any parsing errors
        onError(e.toString());
      }
    },
    onError: (error) {
      // Directly forward errors from the API call
      onError(error);
    },
  );
}

}
