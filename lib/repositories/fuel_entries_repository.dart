import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/database/db_firestore.dart';
import 'package:projeto_moveis_2024/models/dashboard_data.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:projeto_moveis_2024/services/auth_service.dart';

class FuelEntriesRepository extends ChangeNotifier {
  final List<FuelEntry> _fuelEntries = [];
  late FirebaseFirestore db;
  late AuthService auth;

  UnmodifiableListView<FuelEntry> get fuelEntries =>
      UnmodifiableListView(_fuelEntries);

  FuelEntriesRepository({required this.auth}) {
    _startRepository();
    notifyListeners();
  }

  _startRepository() {
    _startFirestore();
    _fuelEntries.clear();
    retrieveFuelEntriesFromDb();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }


  saveFuelEntry(FuelEntry fuelEntry) async {
    await db.collection('users/${auth.usuario!.uid}/fuel_entries').doc().set({
      'date': fuelEntry.date,
      'totalPrice': fuelEntry.totalPrice,
      'pricePerLiter': fuelEntry.pricePerLiter,
      'odometer': fuelEntry.odometer,
      'fuelType': fuelEntry.fuelType,
      'gasStationName': fuelEntry.gasStationName,
      'gasFlag': fuelEntry.gasFlag,
    });
    _fuelEntries.add(fuelEntry);
    notifyListeners();
  }

  Future<void> retrieveFuelEntriesFromDb() async {
    if (auth.usuario != null) {
      final snapshot = await db
          .collection('users/${auth.usuario!.uid}/fuel_entries')
          .get();

      _fuelEntries.clear();
      for (var doc in snapshot.docs) {
        _fuelEntries.add(FuelEntry(
          date: (doc['date'] as Timestamp).toDate(),
          totalPrice: doc['totalPrice'],
          pricePerLiter: doc['pricePerLiter'],
          odometer: doc['odometer'],
          fuelType: doc['fuelType'],
          gasStationName: doc['gasStationName'],
          gasFlag: doc['gasFlag'],
        ));
      }
      notifyListeners();
    }
  }

  List<FuelEntry> getFuelEntries() {
    var entries = fuelEntries.toList();

    entries.sort((a, b) => b.date.compareTo(a.date));

    return entries;
  }

  DashboardData getDashboardData() {
    retrieveFuelEntriesFromDb();
    if (fuelEntries.isEmpty) {
      return DashboardData(totalValue: 0, meanValue: 0, totalLiters: 0, lastRefuelDate: null, entriesCount: 0, isEmpty: true);
    }

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
      isEmpty: false,
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
