import 'dart:collection';

import 'package:flutter/material.dart';
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
          date: DateTime(2024, 11, 30),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 100,
          odometer: 42000,
          pricePerLiter: 6.50,
        ),
        FuelEntry(
          date: DateTime(2024, 11, 30),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 100,
          odometer: 42200,
          pricePerLiter: 6.50,
        ),
        FuelEntry(
          date: DateTime(2024, 11, 30),
          fuelType: 'Gasolina',
          gasStationName: 'Shell Centro',
          totalPrice: 100,
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
