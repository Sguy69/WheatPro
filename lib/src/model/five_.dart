class FiveDayData {
  final String dateTime;
  final int temp;

  // Ensuring values are never null by setting default values
  FiveDayData({required this.dateTime, required this.temp});

  // Factory constructor for creating an instance from JSON
  factory FiveDayData.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException('JSON object cannot be null');
    }

    // Attempt to parse 'dt_txt' and check for validity
    final dtTxt = json['dt_txt'] as String?;
    if (dtTxt == null || dtTxt.isEmpty) {
      throw FormatException('dt_txt is missing or empty');
    }

    // Split the 'dt_txt' to extract date and time parts
    var dateParts = dtTxt.split(' ');
    var date = dateParts[0].split('-');
    var time = dateParts[1].split(':');

    // Construct the dateTime string from parts
    String day = date[2]; // Day from 'yyyy-mm-dd'
    String hour = time[0]; // Hour from 'hh:mm:ss'
    String dateTime = '$day-$hour'; // e.g., '28-14' for 14:00 on the 28th

    // Attempt to parse temperature, convert from Kelvin to Celsius
    final tempStr = json['main']['temp'].toString();
    double? kelvinTemp = double.tryParse(tempStr);
    if (kelvinTemp == null) {
      throw FormatException('Invalid temperature format');
    }
    int celsiusTemp = (kelvinTemp - 273.15).round();

    return FiveDayData(dateTime: dateTime, temp: celsiusTemp);
  }
}
