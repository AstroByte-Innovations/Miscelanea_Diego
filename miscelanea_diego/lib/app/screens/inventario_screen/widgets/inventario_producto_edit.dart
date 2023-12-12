import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/inventario_screen/inventario_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';

class InventarioProductoEdit extends StatefulWidget {
  const InventarioProductoEdit(
      {super.key,
      required this.producto,
      required this.controller,
      required this.controllerInventario,
      required this.usuario});
  final Producto producto;
  final ProductoController controller;
  final InventarioController controllerInventario;
  final Usuario usuario;

  @override
  State<InventarioProductoEdit> createState() => _InventarioProductoEditState();
}

class _InventarioProductoEditState extends State<InventarioProductoEdit> {
  final TextEditingController _cantidadController = TextEditingController();
  late double cantidad;
  final _formKey = GlobalKey<FormState>();
  List<MovimientoAlmacen> movimientos = [];

  void cargarMovimientos() async {
    movimientos = await widget.controllerInventario
        .cargarMovimientosSku(widget.producto.sku);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cantidad = widget.producto.cantidad;
    _cantidadController.text = cantidad.toString();
    cargarMovimientos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.regresarAppBar(context, 'Ediccion de inventario'),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.edit), text: 'Ediccion'),
                Tab(icon: Icon(Icons.move_up), text: 'Movimientos'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Informacion general',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (widget.producto.cantidad <= 0)
                                  ? Colors.red
                                  : (widget.producto.cantidad > 5)
                                      ? Colors.green
                                      : Colors.yellow,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estado: ${(widget.producto.estado == 0) ? 'Sin Inventario' : widget.producto.estado == 2 ? 'Disponible' : 'Poco Inventario'}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'SKU: ${widget.producto.sku}\nNombre: ${widget.producto.nombre}',
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  'Categoria: ${widget.producto.categoria.nombre}'),
                            ],
                          )
                        ],
                      ),
                      const Divider(height: 40),
                      Form(
                          key: _formKey,
                          child: ListTile(
                            leading: IconButton.filled(
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditInventario(
                                          cantidad: widget.producto.cantidad,
                                          tipo: 'remover',
                                        );
                                      }).then((value) {
                                    if (value != null) {
                                      double cantidadA =
                                          widget.producto.cantidad;
                                      double cantidad = double.parse(value);
                                      double cantidadF = cantidadA - cantidad;
                                      widget.producto.cantidad = cantidadF;
                                      if (widget.producto.cantidad < 0) {
                                        widget.producto.estado = 0;
                                      } else if (widget.producto.cantidad > 5) {
                                        widget.producto.estado = 2;
                                      } else {
                                        widget.producto.estado = 1;
                                      }
                                      widget.controller.actualizarProducto(
                                          widget.producto.key, widget.producto);
                                      widget.controllerInventario
                                          .agregarMovimiento(MovimientoAlmacen(
                                              sku: widget.producto.sku,
                                              nombre: widget.producto.nombre,
                                              fecha: DateTime.now(),
                                              tipo: 0,
                                              cantidadA: cantidadA,
                                              cantidad: cantidad,
                                              cantidadF: cantidadF,
                                              usuario: widget.usuario));
                                      cargarMovimientos();
                                      setState(() {
                                        this.cantidad = cantidadF;
                                        _cantidadController.text =
                                            this.cantidad.toString();
                                      });
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.white,
                                )),
                            title: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Cantidad *')),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                              controller: _cantidadController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Favor de ingresar un numero valido';
                                }
                                if (double.parse(value) < 0) {
                                  _cantidadController.text = '0';
                                  return 'No puede a ver numeros negativos';
                                }
                                return null;
                              },
                            ),
                            trailing: IconButton.filled(
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditInventario(
                                          cantidad: widget.producto.cantidad,
                                          tipo: 'añadir',
                                        );
                                      }).then((value) {
                                    if (value != null) {
                                      double cantidadA =
                                          widget.producto.cantidad;
                                      double cantidad = double.parse(value);
                                      double cantidadF = cantidadA + cantidad;
                                      widget.producto.cantidad = cantidadF;
                                      if (widget.producto.cantidad < 0) {
                                        widget.producto.estado = 0;
                                      } else if (widget.producto.cantidad > 5) {
                                        widget.producto.estado = 2;
                                      } else {
                                        widget.producto.estado = 1;
                                      }
                                      widget.controller.actualizarProducto(
                                          widget.producto.key, widget.producto);
                                      widget.controllerInventario
                                          .agregarMovimiento(MovimientoAlmacen(
                                              sku: widget.producto.sku,
                                              nombre: widget.producto.nombre,
                                              fecha: DateTime.now(),
                                              tipo: 1,
                                              cantidadA: cantidadA,
                                              cantidad: cantidad,
                                              cantidadF: cantidadF,
                                              usuario: widget.usuario));
                                      cargarMovimientos();
                                      setState(() {
                                        this.cantidad = cantidadF;
                                        _cantidadController.text =
                                            this.cantidad.toString();
                                      });
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                  Column(children: [
                    const Text('Movimientos:'),
                    Expanded(
                        child: ListView.builder(
                            itemCount: movimientos.length,
                            itemBuilder: (c, i) {
                              return Card(
                                color: (movimientos[i].tipo == 1)
                                    ? Colors.green.shade400
                                    : Colors.red.shade400,
                                child: ListTile(
                                  leading: Icon((movimientos[i].tipo == 1)
                                      ? Icons.add
                                      : Icons.remove),
                                  title: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Column(children: [
                                      Text((movimientos[i].tipo == 1)
                                          ? 'Alta'
                                          : 'Baja'),
                                      Text(
                                        'Usuario: ${movimientos[i].usuario.nombreUsuario}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Divider(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Anterior\n ${movimientos[i].cantidadA}',
                                          ),
                                          Text(
                                              'Cantidad\n ${movimientos[i].cantidad}'),
                                          Text(
                                              'Actual\n ${movimientos[i].cantidadF}')
                                        ],
                                      ),
                                      const Divider(height: 5),
                                      Text(
                                        movimientos[i].fecha.toString(),
                                        style: const TextStyle(fontSize: 10),
                                      )
                                    ]),
                                  ),
                                ),
                              );
                            }))
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            double cantidadA = widget.producto.cantidad;
            double cantidad =
                double.parse(_cantidadController.text) - cantidadA;
            if (cantidad != 0) {
              double cantidadF = double.parse(_cantidadController.text);
              widget.producto.cantidad = cantidadF;
              if (widget.producto.cantidad < 0) {
                widget.producto.estado = 0;
              } else if (widget.producto.cantidad > 5) {
                widget.producto.estado = 2;
              } else {
                widget.producto.estado = 1;
              }
              widget.controller
                  .actualizarProducto(widget.producto.key, widget.producto);

              widget.controllerInventario.agregarMovimiento(MovimientoAlmacen(
                  sku: widget.producto.sku,
                  nombre: widget.producto.nombre,
                  fecha: DateTime.now(),
                  tipo: cantidad > 0 ? 1 : 0,
                  cantidadA: cantidadA,
                  cantidad: cantidad.abs(),
                  cantidadF: cantidadF,
                  usuario: widget.usuario));
            }
            Navigator.of(context).pop(1);
          }
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }
}

class EditInventario extends StatefulWidget {
  const EditInventario({super.key, required this.tipo, required this.cantidad});
  final String tipo;
  final double cantidad;

  @override
  State<EditInventario> createState() => _EditInventarioState();
}

class _EditInventarioState extends State<EditInventario> {
  final _cantidadController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cantidadController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200,
        width: 300,
        child: Card(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Ingrese la cantidad a ${widget.tipo}',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Cantidad *'),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    controller: _cantidadController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Favor de ingresar un numero valido';
                      }
                      final double parsedValue = double.tryParse(value) ?? 0.0;
                      if (parsedValue > widget.cantidad &&
                          widget.tipo == 'remover') {
                        return 'No puedes dar de baja mas priductos de los existentes en el inventario';
                      }
                      if (parsedValue < 0) {
                        _cantidadController.text = '0';
                        return 'No puede a ver numeros negativos';
                      }
                      return null;
                    },
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop(_cantidadController.text);
                      }
                    },
                    child: Text(widget.tipo),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
