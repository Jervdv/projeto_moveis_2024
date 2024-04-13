import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import '../models/fuel_entry.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FuelEntriesRepository fuelEntriesRepository = FuelEntriesRepository();
  List<FuelEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    double totalSpent = entries.fold(
        0, (sum, entry) => sum + (entry.liters * entry.pricePerLiter));
    double totalLiters = entries.fold(0, (sum, entry) => sum + entry.liters);
    double averagePricePerLiter =
        entries.isEmpty ? 0 : totalSpent / totalLiters;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
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
