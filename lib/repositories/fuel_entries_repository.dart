import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/models/dashboard_data.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';

class FuelEntriesRepository extends ChangeNotifier {
  final List<FuelEntry> _fuelEntries = [];

  UnmodifiableListView<FuelEntry> get fuelEntries =>
      UnmodifiableListView(_fuelEntries);

  saveFuelEntry(FuelEntry fuelEntry) {
    _fuelEntries.add(fuelEntry);
    notifyListeners();
  }

  FuelEntriesRepository() {
    _fuelEntries.addAll(
      [
        FuelEntry(
          date: DateTime(2024, 1, 31),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 100,
          odometer: 42000,
          pricePerLiter: 6.50,
          gasFlag: 'Shell',
        ),
        FuelEntry(
          date: DateTime(2024, 3, 27),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 100,
          odometer: 42200,
          pricePerLiter: 6.50,
          gasFlag: 'Petrobras',
        ),
        FuelEntry(
          date: DateTime(2024, 2, 10),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 150,
          odometer: 42400,
          pricePerLiter: 6.50,
          gasFlag: 'Shell',
        ),
        FuelEntry(
          date: DateTime(2024, 2, 10),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 150,
          odometer: 42400,
          pricePerLiter: 6.50,
          gasFlag: 'Shell',
        ),
        FuelEntry(
          date: DateTime(2024, 2, 10),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 150,
          odometer: 42400,
          pricePerLiter: 6.50,
          gasFlag: 'Outros',
        ),
        FuelEntry(
          date: DateTime(2024, 2, 10),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 150,
          odometer: 42400,
          pricePerLiter: 6.50,
          gasFlag: 'Outros',
        ),
        FuelEntry(
          date: DateTime(2024, 2, 10),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 150,
          odometer: 42400,
          pricePerLiter: 6.50,
          gasFlag: 'Outros',
        ),
      ],
    );
    notifyListeners();
  }

  List<FuelEntry> getFuelEntries() {
    var entries = fuelEntries.toList();

    entries.sort((a, b) => b.date.compareTo(a.date));

    return entries;
  }

  DashboardData getDashboardData() {
    double totalValue = fuelEntries.fold(
        0, (double sum, FuelEntry entry) => sum + entry.totalPrice);
    double meanValue = totalValue / fuelEntries.length;
    DateTime lastRefuelDate = fuelEntries
        .reduce((currentMax, element) =>
            element.date.isAfter(currentMax.date) ? element : currentMax)
        .date;
    double totalLiters = fuelEntries.fold(
        0, (double sum, FuelEntry entry) => sum + entry.liters);
    return DashboardData(
      totalValue: totalValue,
      meanValue: meanValue,
      totalLiters: totalLiters,
      lastRefuelDate: lastRefuelDate,
      entriesCount: fuelEntries.length,
    );
  }

  Map<String, double> getFlagChartData() {
    Map<String, double> gasFlagData = {};
    double totalCount = fuelEntries.length.toDouble();

    for (FuelEntry entry in fuelEntries) {
      if (gasFlagData.containsKey(entry.gasFlag)) {
        gasFlagData[entry.gasFlag] = gasFlagData[entry.gasFlag]! + 1;
      } else {
        gasFlagData[entry.gasFlag] = 1;
      }
    }

    var keys = gasFlagData.keys.toList();
    for (String key in keys) {
        gasFlagData[key] = gasFlagData[key]! / totalCount;
    }

    return gasFlagData;
  }
  // deleteFuelEntry(FuelEntry fuelEntry) {
  //   final oldNote = _notes.firstWhere(
  //     (n) => n.title == note.title && n.description == note.description,
  //   );
  //   final noteIndex = _notes.indexOf(oldNote);
  //   _notes.replaceRange(noteIndex, noteIndex + 1, [
  //     Note(
  //       title: note.title,
  //       description: note.description,
  //       color: note.color,
  //       archived: true,
  //     )
  //   ]);
  //   notifyListeners();
  // }
}
