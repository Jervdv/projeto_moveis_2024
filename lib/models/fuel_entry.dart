class FuelEntry {
  DateTime date;
  double liters;
  double pricePerLiter;
  int odometer;
  String fuelType;
  String gasStationName;
  bool isDeleted = false;

  FuelEntry({
    required this.date,
    required this.liters,
    required this.pricePerLiter,
    required this.odometer,
    required this.fuelType,
    required this.gasStationName,
  });
}
