import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/model/current_weather_data.dart';
import 'package:flutter_application_1/src/model/five_.dart';
import 'package:flutter_application_1/src/ui/home/air.dart';
import 'package:flutter_application_1/src/ui/home/clound_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CloudScreen extends StatefulWidget {
  @override
  _CloudScreenState createState() => _CloudScreenState();
}

class _CloudScreenState extends State<CloudScreen> {
  int _selectedIndex = 0; // Current index for the navigation bar

  // Adjust the options to include your new screen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the index on tap, triggering a rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<CloudController>(
        builder: (controller) {
          // Decide what content to display based on the selected index
          Widget content;
          switch (_selectedIndex) {
            case 0:
              content = buildHomeContent(controller); // Home content
              break;
            case 1:
              content = Air(); // Air quality widget
              break;
            default:
              content =
                  Text('Page not found'); // Fallback text for undefined tabs
              break;
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: content,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.air),
            label: 'Air',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildHomeContent(CloudController controller) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cloud-in-blue-sky.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: TextField(
                    onChanged: (value) => controller.city.value =
                        value, // Updates the controller's city value with each input change.
                    style: const TextStyle(
                      color: Colors
                          .white, // Sets the text color inside the text field to white.
                    ),
                    textInputAction: TextInputAction
                        .search, // Optimizes the keyboard for search operations.
                    onSubmitted: (value) {
                      controller
                          .updateWeather(); // Calls the function to update the weather when the user submits their search.
                    },
                    decoration: InputDecoration(
                      suffix: const Icon(
                        Icons.search,
                        color: Colors
                            .white, // Adds a search icon inside the text field on the right end.
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.white), // Style for the hint text.
                      hintText: 'Search'
                          .toUpperCase(), // Text displayed in the text field to prompt input.
                      border: OutlineInputBorder(
                        // Defines the border of the text field.
                        borderRadius: BorderRadius.circular(
                            10), // Rounds the corners of the border.
                        borderSide: const BorderSide(
                            color: Colors
                                .white), // Color of the border when the field is not in focus.
                      ),
                      focusedBorder: OutlineInputBorder(
                        // Border style when the text field is focused.
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // Border style when the text field is enabled.
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.0, 1.0),
                  child: SizedBox(
                    height: 20,
                    width: 15,
                    child: OverflowBox(
                      minWidth: 0.0,
                      maxWidth: MediaQuery.of(context).size.width,
                      minHeight: 0.0,
                      maxHeight: (MediaQuery.of(context).size.height / 3.5),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: double.infinity,
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 20, right: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              (controller.currentWeatherData !=
                                                      null)
                                                  ? '${controller.currentWeatherData?.name}'
                                                      .toUpperCase()
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              DateFormat()
                                                  .add_MMMMEEEEd()
                                                  .format(DateTime.now()),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 16,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 50),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              (controller.currentWeatherData
                                                          ?.weather !=
                                                      null)
                                                  ? '${controller.currentWeatherData?.weather[0].description}'
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 22,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              (controller.currentWeatherData
                                                          ?.main !=
                                                      null)
                                                  ? '${(controller.currentWeatherData!.main.temp - 273.15).round().toString()}\u2103'
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.copyWith(
                                                      color: Colors.black45,
                                                      fontFamily:
                                                          'flutterfonts'),
                                            ),
                                            Text(
                                              (controller.currentWeatherData
                                                          ?.main !=
                                                      null)
                                                  ? 'min: ${(controller.currentWeatherData!.main.tempMin - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData!.main.tempMax - 273.15).round().toString()}\u2103'
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'flutterfonts',
                                                  ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              height: 120,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/cloudy_1.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                (controller.currentWeatherData
                                                            ?.wind !=
                                                        null)
                                                    ? 'wind ${controller.currentWeatherData?.wind.speed} m/s'
                                                    : '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'flutterfonts',
                                                    ),
                                              ),
                                              
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('thx for the api (https://aqicn.org/api/),(https://openweathermap.org/api)',style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.black45,
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'flutterfonts',))
                                ],
                              ),
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: const EdgeInsets.only(top: 120),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'other city'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 16,
                                      fontFamily: 'flutterfonts',
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Container(
                          height: 150,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            itemCount: controller.dataList.length,
                            itemBuilder: (context, index) {
                              CurrentWeatherData? data;
                              (controller.dataList.length > 0)
                                  ? data = controller.dataList[index]
                                  : data = null;
                              return Container(
                                width: 140,
                                height: 150,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          (data != null) ? '${data.name}' : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                        Text(
                                          (data != null)
                                              ? '${(data.main.temp - 273.15).round().toString()}\u2103'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45,
                                                fontFamily: 'flutterfonts',
                                              ),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/cloudy_1.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          (data != null)
                                              ? '${data.weather[0].description}'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.black45,
                                                fontFamily: 'flutterfonts',
                                                fontSize: 14,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'forcast next 5 days'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                              ),
                              const Icon(
                                Icons.next_plan_outlined,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              series: <CartesianSeries<FiveDayData, String>>[
                                SplineSeries<FiveDayData, String>(
                                  dataSource: controller.fiveDaysData,
                                  xValueMapper: (FiveDayData f, _) =>
                                      f.dateTime,
                                  yValueMapper: (FiveDayData f, _) => f.temp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
