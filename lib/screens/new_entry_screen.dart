import 'package:flutter/material.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:provider/provider.dart';

class NewEntryScreen extends StatefulWidget {
  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _odometerController = TextEditingController();
  final TextEditingController _pricePerLiterController =
      TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _stationNameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _fuelType = 'Gasolina';
  String _gasFlag = 'Shell';

  saveFuelEntry() {
    if (_formKey.currentState!.validate()) {
      final fuelEntriesRepository = context.read<FuelEntriesRepository>();

      fuelEntriesRepository.saveFuelEntry(FuelEntry(
          date: selectedDate,
          fuelType: _fuelType,
          gasFlag: _gasFlag,
          gasStationName: _stationNameController.text,
          odometer: double.parse(_odometerController.text),
          pricePerLiter: double.parse(_pricePerLiterController.text),
          totalPrice: double.parse(_totalPriceController.text)));
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _pricePerLiterController.dispose();
    _stationNameController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InputDatePickerFormField(
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                  initialDate: selectedDate,
                  acceptEmptyDate: false,
                  fieldLabelText: 'Data do Abastecimento',
                  onDateSubmitted: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  onDateSaved: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
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
                  decoration:
                      const InputDecoration(labelText: 'Bandeira'),
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
                  decoration: const InputDecoration(
                      labelText: 'Quilometragem no Odômetro'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quilometragem';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _totalPriceController,
                  decoration: const InputDecoration(labelText: 'Preço Total'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço do abastecimento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _pricePerLiterController,
                  decoration:
                      const InputDecoration(labelText: 'Preço Por Litro'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço por litro';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: _fuelType,
                  decoration:
                      const InputDecoration(labelText: 'Tipo de Combustível'),
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
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: save on repository
                        saveFuelEntry();
                        print('Odômetro: ${_odometerController.text}');
                        print(
                            'Preço por Litro: ${_pricePerLiterController.text}');
                        print('Tipo de Combustível: $_fuelType');
                        print('Nome do Posto: ${_stationNameController.text}');
                      }
                    },
                    child: const Text('Registrar'),
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
