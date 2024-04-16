import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:projeto_moveis_2024/widgets/navigation_button.dart';
import 'package:projeto_moveis_2024/widgets/dashboard_card.dart';
import 'package:provider/provider.dart';
import '../models/dashboard_data.dart';
import '../models/fuel_entry.dart';
import 'package:pie_chart/pie_chart.dart';

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
    Map<String,double> pieChartData = fuelEntriesRepository.getFlagChartData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomLeft, colors: [ Colors.blue.shade300, Colors.white],)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'App Combustível',
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        DashboardCard(
                          title: 'Valor Total',
                          subtitle: 'R\$ ${data.totalValue.toStringAsFixed(2)}',
                          width: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardCard(
                              title: 'Gasto médio',
                              subtitle: 'R\$ ${data.meanValue.toStringAsFixed(2)}',
                              width: 0.52,
                            ),
                            DashboardCard(
                              title: 'Litros abastecidos',
                              subtitle: '${data.totalLiters.toStringAsFixed(1)}L',
                              width: 0.4,
                            ),
                          ],
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PieChart(
                              chartRadius: 230,
                              dataMap: pieChartData,
                              chartType: ChartType.ring,
                              colorList: [Colors.blue.shade600,Colors.blue.shade900,Colors.blueGrey.shade200, Colors.indigo.shade600, Colors.indigo.shade100],
                              chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true, decimalPlaces: 2),
                              legendOptions: const LegendOptions(legendPosition: LegendPosition.right, showLegendsInRow: false),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NavigationButton(imagePath: 'lib/assets/img/history-button.png', route: '/history',),
                    NavigationButton(imagePath: 'lib/assets/img/add-button.png', route: '/new_entry',),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
