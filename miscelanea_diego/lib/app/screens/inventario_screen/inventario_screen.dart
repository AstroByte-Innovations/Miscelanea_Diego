import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/inventario_screen/inventario_controller.dart';
import 'package:miscelanea_diego/app/screens/inventario_screen/widgets/inventario_producto_edit.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen(
      {super.key,
      required this.usuario,
      required this.controller,
      required this.controllerCategoria,
      required this.controllerInvetario});
  final Usuario usuario;
  final ProductoController controller;
  final CategoriaController controllerCategoria;
  final InventarioController controllerInvetario;

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  List<Producto> _productos = [];
  List<Categoria> _categorias = [];
  List<String> _filtro = [];

  Future<void> _cargar() async {
    if (_filtro.isEmpty) {
      _productos = await widget.controller.cargarProductos();
    } else {
      List<Producto> productosFiltrados =
          await widget.controller.cargarProductos();
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
    return SideMenu(
        background: Theme.of(context).colorScheme.primary,
        key: _sideMenuKey,
        menu: Menu.buildMenu(context, widget.usuario),
        type: SideMenuType.slideNRotate,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  final state = _sideMenuKey.currentState;
                  if (state!.isOpened) {
                    state.closeSideMenu();
                  } else {
                    state.openSideMenu();
                  }
                },
              ),
              title: const Text('Inventario'),
              actions: [
                IconButton(
                    onPressed: () async {
                      _filtro = await showCategoriasFiltro(
                          context, _categorias, _filtro);
                      _cargar();
                    },
                    icon: const Icon(Icons.grid_view))
              ],
            ),
            body: PopScope(
              canPop: false,
              child: Column(children: [
                SizedBox(
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        children: _productos.map((e) {
                          return ProductoView(
                            producto: e,
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (c) {
                                return InventarioProductoEdit(
                                  usuario: widget.usuario,
                                  producto: e,
                                  controller: widget.controller,
                                  controllerInventario:
                                      widget.controllerInvetario,
                                );
                              })).then((value) {
                                {
                                  _cargar();
                                  _cargarCategorias();
                                }
                              });
                            },
                          );
                        }).toList()),
                  ),
                ),
              ]),
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
                GlobalWidgets.showBackDialog(context);
              },
            )));
  }

  Future<List<String>> showCategoriasFiltro(BuildContext context,
      List<Categoria> categorias, List<String> filtro) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: FiltroCategoria(
            categorias: categorias,
            filtro: filtro,
          ));
        }).then((value) {
      if (value != null) {
        filtro = value;
      }
    });
    return filtro;
  }
}

class ProductoView extends StatelessWidget {
  const ProductoView({super.key, required this.producto, required this.onTap});

  final Producto producto;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Card(
          color: GlobalWidgets.getColorFondo(producto.categoria.color).color,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: (producto.cantidad <= 0)
                          ? Colors.red
                          : (producto.cantidad > 5)
                              ? Colors.green
                              : Colors.yellow,
                      size: 50,
                    ),
                    title: Text(
                      producto.nombre,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${producto.sku}\nEstado: ${(producto.estado == 0) ? 'Sin Invetario' : producto.estado == 2 ? 'Disponible' : 'Poco Inventario'}\nCategoria: ${producto.categoria.nombre}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: SizedBox(
                      height: 60,
                      width: 60,
                      child: Column(
                        children: [
                          const Text('Cantidad'),
                          Center(
                            child: (producto.tipo == 1)
                                ? Text(
                                    '${producto.cantidad.round()}',
                                    style: const TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    producto.cantidad.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
