import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:intl/intl.dart';
import 'fuel_entry_details_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final fuelEntriesRepository = context.read<FuelEntriesRepository>();
    await fuelEntriesRepository.retrieveFuelEntriesFromDb(); // Ensure you have this method to load data from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Abastecimentos'),
      ),
      body: Consumer<FuelEntriesRepository>(
        builder: (context, fuelEntriesRepository, child) {
          final entries = fuelEntriesRepository.fuelEntries;

          if (entries.isEmpty) {
            return const Center(
              child: Text('Nenhum abastecimento registrado.'),
            );
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FuelEntryDetailsScreen(entry: entries[index]),
                    ),
                  );

                  if (result == true) {
                    // Refresh the entries if a deletion occurred
                    await _loadEntries();
                  }
                },
                child: Padding(
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
                              child: Text(entries[index].gasStationName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(formatDateTime(entries[index].date), style: const TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                        ListTile(
                          title: Text('Abasteceu R\$ ${entries[index].totalPrice.toStringAsFixed(2)} de ${entries[index].fuelType} por R\$ ${entries[index].pricePerLiter.toStringAsFixed(2)} por litro'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}