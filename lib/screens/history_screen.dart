import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:provider/provider.dart';

import '../repositories/fuel_entries_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
 List<FuelEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    final FuelEntriesRepository fuelEntriesRepository =
      context.read<FuelEntriesRepository>();

    entries = fuelEntriesRepository.getFuelEntries();

    print(entries.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Abastecimentos'),
      ),
      body: entries.isEmpty
          ? const Center(
              child: Text('Nenhum abastecimento registrado.'),
            )
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(entries[index].gasStationName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(entries[index].date.toString(), style: const TextStyle(fontSize: 18),),
                            ),
                          ],
                        ),
                        ListTile(
                          title: Text('Abasteceu R\$ ${entries[index].totalPrice.toStringAsFixed(2)} de ${entries[index].fuelType} por R\$ ${entries[index].pricePerLiter.toStringAsFixed(2)}/l'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}