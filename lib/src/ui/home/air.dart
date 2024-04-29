import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/air_quality.dart';
import 'package:flutter_application_1/data/air_quality_provider.dart';

class Air extends StatefulWidget {
  Air({Key? key}) : super(key: key);

  @override
  _AirState createState() => _AirState();
}

class _AirState extends State<Air> {
  final AQIService _aqiService = AQIService();
  final List<String> locations = [
    'london',
    'beijing',
    'bangkok',
    'paris',
    'tokyo',
    'tianjin',
    'shanghai',
    'Shijiazhuang',
    'london',
    'heze',
    'bangkok'
  ];

  late Map<String, Future<AirQuality>> _aqiFutures;

  @override
  void initState() {
    super.initState();
    _loadAQIData();
  }

  void _loadAQIData() {
    _aqiFutures = {
      for (var location in locations)
        location as String: _aqiService.fetchAirQuality(location as String)
    };
  }

  void _refreshAQIData() {
    setState(_loadAQIData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Air Pollution'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 114, 178, 230),
                  Color.fromARGB(255, 30, 117, 203)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _refreshAQIData,
            ),
          ],
        ),
        body: buildLocationList(context),
      ),
    );
  }

  Widget buildLocationList(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) =>
          buildLocationCard(context, locations[index]),
    );
  }

  Widget buildLocationCard(BuildContext context, String location) {
    return FutureBuilder<AirQuality>(
      future: _aqiService.fetchAirQuality(location),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final airQuality = snapshot.data!;
            return buildAQICard(context, airQuality);
          } else if (snapshot.hasError) {
            return buildErrorTile(location, snapshot.error);
          }
        }
        return buildLoadingTile(location);
      },
    );
  }

  Card buildAQICard(BuildContext context, AirQuality airQuality) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Text(
          airQuality.data.city.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Text('AQI: ${airQuality.data.aqi}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.thermostat_rounded,
              color: _getAQIColor(airQuality.data.aqi),
            ),
            
          ],
        ),
      ),
    );
  }

  ListTile buildLoadingTile(String location) {
    return ListTile(
      title: Text('Loading $location...'),
      subtitle: const LinearProgressIndicator(),
    );
  }

  ListTile buildErrorTile(String location, dynamic error) {
    return ListTile(
      title: Text('Error for $location'),
      subtitle: Text(error.toString()),
    );
  }

  Color _getAQIColor(int aqi) {
    if (aqi <= 50) {
      return Colors.green;
    } else if (aqi <= 100) {
      return Colors.yellow;
    } else if (aqi <= 150) {
      return Colors.orange;
    } else if (aqi <= 200) {
      return Colors.red;
    } else if (aqi <= 300) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }
}
