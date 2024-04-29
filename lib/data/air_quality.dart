// Define the classes according to the JSON structure
class AirQuality {
  String status;
  Data data;

  AirQuality({required this.status, required this.data, required this.isFavorite ,});
   bool isFavorite;

  // A method to parse JSON into your Dart object
  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
        status: json['status'],
        data: Data.fromJson(json['data']), isFavorite: false,
      );

  toJson() {}

  
}


class Data {
  int aqi;
  int idx;
  List<Attribution> attributions;
  City city;
  String dominentpol;
  Iaqi iaqi;
  Time time;
  Forecast forecast;

  Data({
    required this.aqi,
    required this.idx,
    required this.attributions,
    required this.city,
    required this.dominentpol,
    required this.iaqi,
    required this.time,
    required this.forecast,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aqi: json['aqi'],
        idx: json['idx'],
        attributions: List<Attribution>.from(json['attributions'].map((x) => Attribution.fromJson(x))),
        city: City.fromJson(json['city']),
        dominentpol: json['dominentpol'],
        iaqi: Iaqi.fromJson(json['iaqi']),
        time: Time.fromJson(json['time']),
        forecast: Forecast.fromJson(json['forecast']),
      );
}

class Attribution {
  String url;
  String name;

  Attribution({required this.url, required this.name});

  factory Attribution.fromJson(Map<String, dynamic> json) => Attribution(
        url: json['url'],
        name: json['name'],
      );
}

class City {
  List<double> geo;
  String name;
  String url;

  City({
    required this.geo,
    required this.name,
    required this.url,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        geo: List<double>.from(json['geo']),
        name: json['name'],
        url: json['url'],
      );
}
class Iaqi {
  Co co;
  Co h;
  Co no2;
  Co o3;
  Co p;
  Co pm10;
  Co pm25;
  Co so2;
  Co t;
  Co w;

  Iaqi({
    required this.co,
    required this.h,
    required this.no2,
    required this.o3,
    required this.p,
    required this.pm10,
    required this.pm25,
    required this.so2,
    required this.t,
    required this.w,
  });

  factory Iaqi.fromJson(Map<String, dynamic> json) => Iaqi(
        co: Co.fromJson(json['co']),
        h: Co.fromJson(json['h']),
        no2: Co.fromJson(json['no2']),
        o3: Co.fromJson(json['o3']),
        p: Co.fromJson(json['p']),
        pm10: Co.fromJson(json['pm10']),
        pm25: Co.fromJson(json['pm25']),
        so2: Co.fromJson(json['so2']),
        t: Co.fromJson(json['t']),
        w: Co.fromJson(json['w']),
      );
}

class Co {
  double v;

  Co({required this.v});

  factory Co.fromJson(Map<String, dynamic> json) => Co(
        v: (json['v'] as num).toDouble(),
      );
}

class Time {
  final String s;
  final String tz;
  final int v;
  final String iso;

  Time({
    required this.s,
    required this.tz,
    required this.v,
    required this.iso,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      s: json['s'],
      tz: json['tz'],
      v: json['v'],
      iso: json['iso'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's': s,
      'tz': tz,
      'v': v,
      'iso': iso,
    };
  }
}


class Forecast {
  Daily daily;

  Forecast({required this.daily});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        daily: Daily.fromJson(json['daily']),
      );
}

class Daily {
  List<Measure> o3;
  List<Measure> pm10;
  List<Measure> pm25;
  List<Measure> uvi;

  Daily({
    required this.o3,
    required this.pm10,
    required this.pm25,
    required this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        o3: List<Measure>.from(json['o3'].map((x) => Measure.fromJson(x))),
        pm10: List<Measure>.from(json['pm10'].map((x) => Measure.fromJson(x))),
        pm25: List<Measure>.from(json['pm25'].map((x) => Measure.fromJson(x))),
        uvi: List<Measure>.from(json['uvi'].map((x) => Measure.fromJson(x))),
      );
}

class Measure {
  int avg;
  String day;
  int max;
  int min;

  Measure({
    required this.avg,
    required this.day,
    required this.max,
    required this.min,
  });

  factory Measure.fromJson(Map<String, dynamic> json) => Measure(
        avg: json['avg'],
        day: json['day'],
        max: json['max'],
        min: json['min'],
      );
}


// ... (Continue for Iaqi, Time, Forecast, etc., following the same pattern)

