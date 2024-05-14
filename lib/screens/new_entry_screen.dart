import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_moveis_2024/models/fuel_entry.dart';
import 'package:projeto_moveis_2024/repositories/fuel_entries_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
  final TextEditingController _dateController = TextEditingController();

  String _fuelType = 'Gasolina';
  String _gasFlag = 'Shell';

  saveFuelEntry() {
    if (_formKey.currentState!.validate()) {
      final fuelEntriesRepository = context.read<FuelEntriesRepository>();

      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      DateTime dateToAdd = formatter.parseStrict(_dateController.text);

      var uuid = const Uuid();

      fuelEntriesRepository.saveFuelEntry(FuelEntry(
          id: uuid.v1(),
          date: dateToAdd,
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
                TextField(
                      controller: _dateController,
                        decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                labelText: "Digite a data"
                          ),
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                  );

                    if(pickedDate != null ){
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
                    if (double.tryParse(value) == null) {
                      return 'Digite um valor válido para o odômetro.';
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
                    if (double.tryParse(value) == null) {
                      return 'Digite um valor válido para o preço total.';
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
                    if (double.tryParse(value) == null) {
                      return 'Digite um valor válido para o preço por litro.';
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
                        saveFuelEntry();
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
