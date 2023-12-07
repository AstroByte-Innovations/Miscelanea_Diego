import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';

class ProductoForm extends StatefulWidget {
  const ProductoForm({super.key});

  @override
  State<ProductoForm> createState() => _ProductoFormState();
}

class _ProductoFormState extends State<ProductoForm> {
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  Categoria? categoria;
  final TextEditingController _precioController = TextEditingController();
  int? tipo = 1;
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  void _Cargar() {
    setState(() {});
  }

  List<DropdownMenuItem<int>> items = [
    const DropdownMenuItem(
      value: 1,
      child: Text('Pieza'),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text('Granel'),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cantidadController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, 'Crear productos'),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Form(
            child: Column(
          children: [
            const Text('Informacion'),
            TextFormField(
              controller: _skuController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('SKU *')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un SKU válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Nombre *')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un nombre válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Row(
                children: [
                  Icon(Icons.circle),
                  SizedBox(
                    width: 5,
                  ),
                  Text('No seleccionada*')
                ],
              ),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ),
            TextFormField(
              controller: _precioController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Precio *')),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un precio válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Tipo de producto *')),
              value: tipo, // Valor seleccionado por defecto
              items: items,
              onChanged: (value) {
                tipo = value;
                _Cargar();
              },
            ),
            const SizedBox(height: 10),
            const Text('Adiccional'),
            TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Cantidad')),
                keyboardType: TextInputType.number,
                validator: (value) {
                  try {
                    if (value == null || double.parse(value) < 0) {
                      return 'La cantidad debe ser mayor o igual a 0';
                    }
                    return null;
                  } catch (e) {
                    return 'Por favor, ingresa una cantidad válido.';
                  }
                }),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Descripcion')),
            ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
