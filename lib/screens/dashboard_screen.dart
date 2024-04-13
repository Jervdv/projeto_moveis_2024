import 'package:flutter/material.dart';
import '../models/fuel_entry.dart';

class DashboardScreen extends StatelessWidget {
  final List<FuelEntry> entries;

  const DashboardScreen({super.key, required this.entries});

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
