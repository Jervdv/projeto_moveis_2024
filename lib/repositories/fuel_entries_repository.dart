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
        ),
        FuelEntry(
          date: DateTime(2024, 3, 27),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 100,
          odometer: 42200,
          pricePerLiter: 6.50,
        ),
        FuelEntry(
          date: DateTime(2024, 2, 10),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 150,
          odometer: 42400,
          pricePerLiter: 6.50,
        ),
      ],
    );
    notifyListeners();
  }

  List<FuelEntry> getFuelEntries(bool showDeleted) {
    return fuelEntries
        .where((fuelEntry) => fuelEntry.isDeleted == !showDeleted)
        .toList();
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
