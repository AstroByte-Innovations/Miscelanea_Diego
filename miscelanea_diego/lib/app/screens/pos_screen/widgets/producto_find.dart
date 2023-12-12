import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/widgets/producto_find_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';

class ProductoFind extends StatefulWidget {
  const ProductoFind(
      {super.key,
      required this.usuario,
      required this.controllerProducto,
      required this.controllerCategoria,
      required this.controller,
      required this.carrito});
  final Usuario usuario;
  final ProductoController controllerProducto;
  final CategoriaController controllerCategoria;
  final ProductoFindController controller;
  final List<Producto> carrito;

  @override
  State<ProductoFind> createState() => _ProdcuctoFindState();
}

class _ProdcuctoFindState extends State<ProductoFind> {
  List<Producto> _productos = [];
  List<Categoria> _categorias = [];
  List<String> _filtro = [];

  Future<void> _cargar() async {
    List<Producto> lista = await widget.controllerProducto.cargarProductos();
    if (_filtro.isEmpty) {
      _productos = lista.where((element) => element.cantidad != 0).toList();
    } else {
      List<Producto> productosFiltrados =
          lista.where((element) => element.cantidad != 0).toList();
      _productos = productosFiltrados
          .where((element) => _filtro.contains(element.categoria.nombre))
          .toList();
    }
    setState(() {});
  }

  Future<void> _cargarCategorias() async {
    _categorias = await widget.controllerCategoria.cargarCategorias();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargar();
    _cargarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(widget.carrito);
            },
          ),
          title: const Text('Encontrar producto'),
          actions: [
            IconButton(
                onPressed: () async {
                  _filtro =
                      await showCategoriasFiltro(context, _categorias, _filtro);
                  _cargar();
                },
                icon: const Icon(Icons.grid_view)),
            // IconButton(
            //     onPressed: () {}, icon: const Icon(Icons.one_x_mobiledata))
          ],
        ),
        body: PopScope(
          canPop: false,
          child: Column(children: [
            Expanded(
              child: Column(
                children: [
                  categoriasFilter(),
                  SingleChildScrollView(
                    child: mostrarProductosGrid(),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop(widget.carrito);
                      },
                      child: ListTile(
                        title: Text(
                          '${widget.carrito.length} productos = \$ ${widget.controller.total(widget.carrito)}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.white,
                        ),
                      ))),
            )
          ]),
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            Navigator.of(context).pop(widget.carrito);
          },
        ));
  }

  Future<List<String>> showCategoriasFiltro(BuildContext context,
      List<Categoria> categorias, List<String> filtro) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: FiltroCategoria(
            categorias: _categorias,
            filtro: _filtro,
          ));
        }).then((value) {
      if (value != null) {
        filtro = value;
      }
    });
    return filtro;
  }

  Widget categoriasFilter() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          itemCount: _categorias.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: FilterChip(
                  label: Text(_categorias[i].nombre),
                  selected: _filtro.contains(_categorias[i].nombre),
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        _filtro.add(_categorias[i].nombre);
                        _cargar();
                      } else {
                        _filtro.remove(_categorias[i].nombre);
                        _cargar();
                      }
                    });
                  }),
            );
          }),
    );
  }

  Widget mostrarProductosGrid() {
    return Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: _productos.map((e) {
          return ProductoView(
            producto: e,
            agregar: () {
              widget.carrito.add(e);
              setState(() {});
            },
          );
        }).toList());
  }
}

class ProductoView extends StatelessWidget {
  const ProductoView(
      {super.key, required this.producto, required this.agregar});

  final Producto producto;
  final void Function()? agregar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        agregar?.call();
        ElegantNotification.success(
          toastDuration: const Duration(seconds: 2),
          width: 400,
          notificationPosition: NotificationPosition.topLeft,
          animation: AnimationType.fromLeft,
          title: const Text('Producto agregado'),
          description: Text('Producto ${producto.sku} agregado'),
          onDismiss: () {},
        ).show(context);
      },
      child: SizedBox(
        height: 170,
        width: 170,
        child: Card(
          color: GlobalWidgets.getColorFondo(producto.categoria.color).color,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  producto.sku,
                                  style: const TextStyle(fontSize: 8),
                                ),
                                Text(
                                  producto.nombre,
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '\$ ${producto.precio}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  producto.categoria.nombre,
                                  style: const TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class FiltroCategoria extends StatefulWidget {
  final List<Categoria> categorias;
  final List<String> filtro;

  const FiltroCategoria(
      {super.key, required this.categorias, required this.filtro});

  @override
  State<FiltroCategoria> createState() => _FiltroCategoriaState();
}

class _FiltroCategoriaState extends State<FiltroCategoria> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.categorias.map((e) {
                  return FilterChip(
                      label: Text(e.nombre),
                      selected: widget.filtro.contains(e.nombre),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            widget.filtro.add(e.nombre);
                          } else {
                            widget.filtro.remove(e.nombre);
                          }
                        });
                      });
                }).toList()),
          )),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.filtro.clear();
                  Navigator.of(context).pop(widget.filtro);
                },
                child: const Text('Limpiar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop(widget.filtro);
                },
                child: const Text('Aplicar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
