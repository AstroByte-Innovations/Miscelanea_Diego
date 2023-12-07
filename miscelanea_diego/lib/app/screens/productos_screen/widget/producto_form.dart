import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/widget/categorias_card.dart';
import 'package:vibration/vibration.dart';

class ProductoForm extends StatefulWidget {
  const ProductoForm(
      {super.key, required this.usuario, required this.controller});
  final Usuario usuario;
  final ProductoController controller;

  @override
  State<ProductoForm> createState() => _ProductoFormState();
}

class _ProductoFormState extends State<ProductoForm> {
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  late Categoria categoria;
  final TextEditingController _precioController = TextEditingController();
  int tipo = 1;
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Categoria> _categorias = [];

  Future<void> _cargarCategoria() async {
    _categorias =
        await CategoriaController(usuario: widget.usuario).cargarCategorias();
    setState(() {});
  }

  void _cargar() {
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
    categoria = Categoria(nombre: 'No seleccionado', color: -1);
    _cargarCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, 'Crear producto'),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Informacion',
                    style: TextStyle(fontSize: 20),
                  ),
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
                      if (value != null) {
                        tipo = value;
                      }
                      _cargar();
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Categoria', style: TextStyle(fontSize: 20)),
                  const Divider(height: 5),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: (categoria.color != -1)
                              ? GlobalWidgets.getColorFondo(categoria.color)
                                  .color
                              : Colors.grey.shade700,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(categoria.nombre)
                      ],
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CategoriaCard.categoriaEscoger(
                                    context, _categorias);
                              }).then((value) {
                            if (value != null) {
                              categoria = value;
                              _cargar();
                            }
                          });
                        },
                        icon: const Icon(Icons.add)),
                  ),
                  const Divider(height: 10),
                  const Text('Adiccional', style: TextStyle(fontSize: 20)),
                  TextFormField(
                      controller: _cantidadController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Cantidad')),
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
                        border: OutlineInputBorder(),
                        label: Text('Descripcion')),
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (categoria.color == -1) {
            Vibration.vibrate(pattern: [200, 100, 200]);
            showDialog(
                context: context,
                builder: (context) {
                  return GlobalWidgets.mensajeError(
                      "Por favor, antes de continuar, asegúrate de asignar una categoría al producto.",
                      "Categoría no\nseleccionada",
                      context);
                });
          }
          if (_formKey.currentState!.validate()) {
            Producto producto = Producto(
                sku: _skuController.text,
                nombre: _nombreController.text,
                precio: double.parse(_precioController.text),
                estado: (int.parse(_cantidadController.text) == 0)
                    ? 0
                    : (int.parse(_cantidadController.text) > 5)
                        ? 2
                        : 1,
                tipo: tipo,
                categoria: categoria,
                cantidad: double.parse(_cantidadController.text),
                descrcipcion: _descripcionController.text,
                fechaActualizacion: DateTime.now(),
                fechaCreacion: DateTime.now());
            widget.controller.creatProducto(producto);
            Navigator.of(context).pop(1);
          }
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
