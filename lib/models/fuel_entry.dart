class FuelEntry {
  DateTime date;
  double liters;
  double pricePerLiter;
  int odometer;
  String fuelType;

  FuelEntry({
    required this.date,
    required this.liters,
    required this.pricePerLiter,
    required this.odometer,
    required this.fuelType,
  });
}
