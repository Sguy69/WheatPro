import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/model/current_weather_data.dart';
import 'package:flutter_application_1/src/model/five_.dart';

import 'package:flutter_application_1/src/service/weather_service.dart';
import 'package:get/get.dart';

class CloudController extends GetxController {
  // Use RxString for reactive properties that trigger updates.
  final RxString city = ''.obs; // Using final since RxString will manage changes internally
  final RxString searchText = ''.obs;

  // Nullable properties to handle uninitialized state.
  CurrentWeatherData? currentWeatherData;
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  void fetchInitialData() {
    getCurrentWeatherData();
    getTopFiveCities();
    getFiveDaysData();
  }

  void updateWeather() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void setCity(String newCity) {
    if (city.value != newCity) {
      city.value = newCity; // Update the city only if it's different
      updateWeather(); // Refetch weather data for the new city
    }
  }

  void getCurrentWeatherData() {
    WeatherService(city: city.value).getCurrentWeatherData(
      onSuccess: (data) {
        currentWeatherData = data;
        update(); // Notify listeners to update
      },
      onError: (error) {
        print('Error getting current weather: $error');
        update(); // Notify listeners even on error to update error message display if needed
      }
    );
  }

  void getTopFiveCities() {
    const List<String> cities = ['Bangkok','London', 'New York', 'Paris', 'Moscow', 'Tokyo','lopburi','Pattaya','barcelona','Buenos Aires'];
    dataList.clear(); // Clear previous data
    for (var c in cities) {
      WeatherService(city: c).getCurrentWeatherData(
        onSuccess: (data) {
          dataList.add(data);
          update(); // Update the UI after each city data is fetched
        },
        onError: (error) {
          print('Error fetching city data for $c: $error');
          update(); // Even on error, update UI to show that data fetch attempt was made
        }
      );
    }
  }

  RxBool isLoading = false.obs;

void getFiveDaysData() {
  isLoading.value = true;
  WeatherService(city: city.value).getFiveDaysThreeHoursForecastData(
    onSuccess: (data) {
      fiveDaysData = data;
      isLoading.value = false;
      update(); // Update the UI with the new forecast data
    },
    onError: (error) {
      print('Error getting five-day forecast: $error');
      isLoading.value = false;
      update(); // Notify for UI update even on error
    }
  );
}


}
