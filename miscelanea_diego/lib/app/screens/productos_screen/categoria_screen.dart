import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/global_widgets/colorfondo.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({super.key, required this.controller});
  final CategoriaController controller;

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  List<Categoria> _categorias = [];

  Future<void> _cargar() async {
    _categorias = await widget.controller.cargarCategorias();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, 'Categorias'),
      body: ListView.builder(
          itemCount: _categorias.length,
          itemBuilder: (context, index) {
            return Card(
              color:
                  GlobalWidgets.getColorFondo(_categorias[index].color).color,
              child: ListTile(
                title: Text(
                  _categorias[index].nombre,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CategoriaEdit(
                    controller: widget.controller,
                    categoria: _categorias[index],
                  );
                })).then((value) => {if (value != null) _cargar()}),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CategoriaForm(
            controller: widget.controller,
          );
        })).then((value) => {if (value != null) _cargar()}),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CategoriaForm extends StatefulWidget {
  const CategoriaForm({super.key, required this.controller});
  final CategoriaController controller;

  @override
  CategoriaFormState createState() => CategoriaFormState();
}

class CategoriaFormState extends State<CategoriaForm> {
  final TextEditingController _nombreController = TextEditingController();
  ColorFondo colorCategoria = GlobalWidgets.getColorFondo(Random().nextInt(11));
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nombreController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, 'Crear Categoria'),
      body: Container(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                const Divider(height: 30),
                const Text('Color de categoria: '),
                ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: colorCategoria.color,
                  ),
                  title: Text(colorCategoria.nombre),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return GlobalWidgets.coloresFondo(context);
                            }).then((value) {
                          if (value != null) {
                            colorCategoria = value;
                            setState(() {});
                          }
                        });
                      },
                      icon: const Icon(Icons.edit)),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Categoria categoria = Categoria(
                nombre: _nombreController.text,
                color: colorCategoria.key,
                fechaCreacion: DateTime.now(),
                fechaActualizacion: DateTime.now());
            widget.controller.crearCategoria(categoria);
            Navigator.of(context).pop(1);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class CategoriaEdit extends StatefulWidget {
  const CategoriaEdit(
      {super.key, required this.categoria, required this.controller});
  final Categoria categoria;
  final CategoriaController controller;

  @override
  CategoriaEditState createState() => CategoriaEditState();
}

class CategoriaEditState extends State<CategoriaEdit> {
  final TextEditingController _nombreController = TextEditingController();
  late ColorFondo colorCategoria;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nombreController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nombreController.text = widget.categoria.nombre;
    colorCategoria = GlobalWidgets.getColorFondo(widget.categoria.color);
  }

  void close() {
    Navigator.of(context).pop(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarEditarAppBar(
          context, 'Actualizar categoria', () async {
        bool accion = await GlobalWidgets.mesajeConfirmar('Eliminar Categoria',
            '¿Esta seguro de que desea eliminar este usuario?', context);
        if (accion) {
          widget.controller
              .eliminarCategoria(widget.categoria.key, widget.categoria);
          close();
        }
      }),
      body: Container(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Nombre*')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un nombre válido.';
                    }
                    return null;
                  },
                ),
                const Divider(height: 30),
                const Text('Color de categoria: '),
                ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: colorCategoria.color,
                  ),
                  title: Text(colorCategoria.nombre),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return GlobalWidgets.coloresFondo(context);
                            }).then((value) {
                          if (value != null) {
                            colorCategoria = value;
                            setState(() {});
                          }
                        });
                      },
                      icon: const Icon(Icons.edit)),
                ),
                const Divider(height: 30),
                const Text('Informacion adicional'),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha de ultima actualizacion: ${widget.categoria.fechaActualizacion}',
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Fecha de creacion: ${widget.categoria.fechaCreacion}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget.categoria.nombre = _nombreController.text;
            widget.categoria.color = colorCategoria.key;
            widget.categoria.fechaActualizacion = DateTime.now();
            widget.controller
                .actualizarCategoria(widget.categoria, widget.categoria.key);
            close();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
