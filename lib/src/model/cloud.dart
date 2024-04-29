class Clouds {
  final int all;

  // Constructor that requires 'all' to be non-null, no default value provided here
  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Provide a sensible default if json is null; this might not be necessary if your API guarantees this field
      return Clouds(all: 0);
    }

    // Use a default value for 'all' if not present in the json
    return Clouds(
      all: json['all'] ?? 0,
    );
  }
}
