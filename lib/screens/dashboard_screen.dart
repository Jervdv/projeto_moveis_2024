import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:projeto_moveis_2024/widgets/add_button.dart';
import 'package:projeto_moveis_2024/widgets/dashboard_card.dart';
import 'package:provider/provider.dart';
import '../models/dashboard_data.dart';
import '../models/fuel_entry.dart';
import 'package:intl/intl.dart';

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

    DashboardData data = fuelEntriesRepository.getDashboardData();

    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(data.lastRefuelDate);
    print(outputDate);
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Gerenciador de Combustível',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    DashboardCard(
                      title: 'Valor Total',
                      subtitle: 'R\$ ${data.totalValue.toStringAsFixed(2)}',
                      width: 0.8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCard(
                          title: 'Valor médio',
                          subtitle: 'R\$ ${data.meanValue.toStringAsFixed(2)}',
                          width: 0.4,
                        ),
                        DashboardCard(
                          title: 'Litros abastecidos',
                          subtitle: '${data.totalLiters.toStringAsFixed(1)}L',
                          width: 0.4,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCard(
                          title: 'Ultimo Abastecimento',
                          subtitle: outputDate,
                          width: 0.4,
                        ),
                        DashboardCard(
                          title: 'Registros',
                          subtitle: '${data.entriesCount}',
                          width: 0.4,
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, '/new_entry');
                    //   },
                    //   child: const Text('Registrar Abastecimento'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AddButton(imagePath: 'lib/assets/img/add-button.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
