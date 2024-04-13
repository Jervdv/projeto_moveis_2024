import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:provider/provider.dart';
import '../models/fuel_entry.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<FuelEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    final FuelEntriesRepository fuelEntriesRepository =
        context.watch<FuelEntriesRepository>();

    for (var i = 0; i < fuelEntriesRepository.fuelEntries.length; i++) {
      print(fuelEntriesRepository.fuelEntries[i].gasStationName);
    }
    double totalSpent = entries.fold(
        0, (sum, entry) => sum + (entry.liters * entry.pricePerLiter));
    double totalLiters = entries.fold(0, (sum, entry) => sum + entry.liters);
    double averagePricePerLiter =
        entries.isEmpty ? 0 : totalSpent / totalLiters;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: const Text('Dashboard',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 30.0)),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('BCC-2024/1',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0)),
                Icon(Icons.arrow_drop_down, color: Colors.black54)
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Total Gasto: R\$${totalSpent.toStringAsFixed(2)}'),
            Text('Total Litros: ${totalLiters.toStringAsFixed(2)}L'),
            Text(
                'Preço Médio por Litro: R\$${averagePricePerLiter.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new_entry');
              },
              child: const Text('Registrar Abastecimento'),
            ),
          ],
        ),
      ),
    );
  }
}
