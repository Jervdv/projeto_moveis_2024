class FuelEntry {
  DateTime date;
  late double liters;
  double totalPrice;
  double pricePerLiter;
  double odometer;
  String fuelType;
  String gasStationName;
  bool isDeleted = false;

  FuelEntry({
    required this.date,
    required this.pricePerLiter,
    required this.odometer,
    required this.fuelType,
    required this.gasStationName,
    required this.totalPrice,
  }) {
    liters = totalPrice / pricePerLiter;
  }
}
