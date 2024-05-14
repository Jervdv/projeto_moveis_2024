class DashboardData {
  double totalValue;
  double meanValue;
  double totalLiters;
  DateTime? lastRefuelDate;
  int entriesCount;
  bool isEmpty;

  DashboardData({
    required this.totalValue,
    required this.meanValue,
    required this.totalLiters,
    required this.lastRefuelDate,
    required this.entriesCount,
    required this.isEmpty,
  });
}
