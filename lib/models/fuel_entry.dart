class FuelEntry {
  DateTime date;
  late double liters;
  double totalPrice;
  double pricePerLiter;
  double odometer;
  String fuelType;
  String gasStationName;
  String gasFlag;
  String id;
  bool isDeleted = false;

  FuelEntry({
    required this.id,
    required this.date,
    required this.pricePerLiter,
    required this.odometer,
    required this.fuelType,
    required this.gasStationName,
    required this.totalPrice,
    required this.gasFlag,
  }) {
    liters = totalPrice / pricePerLiter;
  }
}
