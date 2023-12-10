import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';

class InventarioProductoEdit extends StatefulWidget {
  const InventarioProductoEdit(
      {super.key, required this.producto, required this.controller});
  final Producto producto;
  final ProductoController controller;

  @override
  State<InventarioProductoEdit> createState() => _InventarioProductoEditState();
}

class _InventarioProductoEditState extends State<InventarioProductoEdit> {
  final TextEditingController _cantidadController = TextEditingController();
  late double cantidad;
  @override
  void initState() {
    super.initState();
    cantidad = widget.producto.cantidad;
    _cantidadController.text = cantidad.toString();
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
                  Expanded(
                      child: Column(
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
                                'SKU: ${widget.producto.sku}\nNombre: ${widget.producto.nombre}',
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Estado: ${(widget.producto.estado == 0) ? 'Sin Inventario' : widget.producto.estado == 2 ? 'Disponible' : 'Poco Inventario'}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                  'Categoria: ${widget.producto.categoria.nombre}'),
                            ],
                          )
                        ],
                      ),
                      const Divider(height: 40),
                      // const Text(
                      //   'Cantidad',
                      //   style: TextStyle(
                      //       fontSize: 25, fontWeight: FontWeight.w500),
                      // ),
                      Form(
                          child: ListTile(
                        leading: IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              size: 35,
                              color: Colors.white,
                            )),
                        title: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Cantidad *')),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 25),
                          controller: _cantidadController,
                        ),
                        trailing: IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.white,
                            )),
                      ))
                    ],
                  )),
                  Container()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(
          Icons.save,
        ),
      ),
    );
  }
}
