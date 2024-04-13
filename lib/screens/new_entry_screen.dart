import 'package:flutter/material.dart';

class NewEntryScreen extends StatefulWidget {
  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _odometerController = TextEditingController();
  final TextEditingController _pricePerLiterController =
      TextEditingController();
  final TextEditingController _stationNameController = TextEditingController();
  String _fuelType = 'Gasolina';

  @override
  void dispose() {
    _odometerController.dispose();
    _pricePerLiterController.dispose();
    _stationNameController.dispose();
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aqui você pode adicionar a lógica para salvar os dados ou alguma ação após o formulário ser validado e salvo
                        print('Odômetro: ${_odometerController.text}');
                        print(
                            'Preço por Litro: ${_pricePerLiterController.text}');
                        print('Tipo de Combustível: $_fuelType');
                        print('Nome do Posto: ${_stationNameController.text}');
                        Navigator.pop(context);
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
