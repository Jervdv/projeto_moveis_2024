import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:provider/provider.dart';

class FuelEntryDetailsScreen extends StatefulWidget {
  final FuelEntry entry;

  const FuelEntryDetailsScreen({super.key, required this.entry});

  @override
  _FuelEntryDetailsScreenState createState() => _FuelEntryDetailsScreenState();
}

class _FuelEntryDetailsScreenState extends State<FuelEntryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _odometerController;
  late TextEditingController _pricePerLiterController;
  late TextEditingController _totalPriceController;
  late TextEditingController _stationNameController;
  late TextEditingController _dateController;

  String _fuelType = 'Gasolina';
  String _gasFlag = 'Shell';

  @override
  void initState() {
    super.initState();
    _odometerController = TextEditingController(text: widget.entry.odometer.toString());
    _pricePerLiterController = TextEditingController(text: widget.entry.pricePerLiter.toString());
    _totalPriceController = TextEditingController(text: widget.entry.totalPrice.toString());
    _stationNameController = TextEditingController(text: widget.entry.gasStationName);
    _dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(widget.entry.date));
    _fuelType = widget.entry.fuelType;
    _gasFlag = widget.entry.gasFlag;
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _pricePerLiterController.dispose();
    _totalPriceController.dispose();
    _stationNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void updateFuelEntry() {
    if (_formKey.currentState!.validate()) {
      final fuelEntriesRepository = context.read<FuelEntriesRepository>();

      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      DateTime dateToAdd = formatter.parseStrict(_dateController.text);

      fuelEntriesRepository.updateFuelEntry(FuelEntry(
        id: widget.entry.id, // Assuming FuelEntry has an id field
        date: dateToAdd,
        fuelType: _fuelType,
        gasFlag: _gasFlag,
        gasStationName: _stationNameController.text,
        odometer: double.parse(_odometerController.text),
        pricePerLiter: double.parse(_pricePerLiterController.text),
        totalPrice: double.parse(_totalPriceController.text),
      ));

      Navigator.pop(context);
    }
  }

  Future<void> deleteFuelEntry() async {
    final fuelEntriesRepository = context.read<FuelEntriesRepository>();
    await fuelEntriesRepository.deleteFuelEntry(widget.entry.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Digite a data"
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                        _dateController.text = formattedDate;
                      });
                    }
                  }
                ),
                TextFormField(
                  controller: _stationNameController,
                  decoration: const InputDecoration(labelText: 'Nome do posto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do posto';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _gasFlag,
                  decoration: const InputDecoration(labelText: 'Bandeira'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _gasFlag = newValue!;
                    });
                  },
                  items: <String>[
                    'Petrobras',
                    'Ipiranga',
                    'Shell',
                    'Ale',
                    'Boxler',
                    'Setee',
                    'Rede Graal',
                    'Outros',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  controller: _odometerController,
                  decoration: const InputDecoration(labelText: 'Quilometragem no Odômetro'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quilometragem';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Digite um valor válido para o odômetro.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _totalPriceController,
                  decoration: const InputDecoration(labelText: 'Preço Total'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço do abastecimento';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Digite um valor válido para o preço total.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pricePerLiterController,
                  decoration: const InputDecoration(labelText: 'Preço Por Litro'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço por litro';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Digite um valor válido para o preço por litro.';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _fuelType,
                  decoration: const InputDecoration(labelText: 'Tipo de Combustível'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fuelType = newValue!;
                    });
                  },
                  items: <String>[
                    'Gasolina',
                    'Etanol',
                    'Gás Veícular (GNV)',
                    'Diesel'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateFuelEntry();
                          }
                        },
                        child: const Text('Atualizar'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await deleteFuelEntry();
                          Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Excluir'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}