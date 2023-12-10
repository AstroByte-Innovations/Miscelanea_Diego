import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/categoria.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_screen.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/widget/producto_edit.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/widget/producto_form.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen(
      {super.key,
      required this.usuario,
      required this.controller,
      required this.controllerCategoria});
  final Usuario usuario;
  final ProductoController controller;
  final CategoriaController controllerCategoria;

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
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
            title: const Text('Productos'),
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CategoriaScreen(
                          controller: widget.controllerCategoria,
                        );
                      })).then((value) {
                        _cargar();
                        _cargarCategorias();
                      }),
                  icon: const Icon(Icons.category_rounded)),
              const SizedBox(width: 10),
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
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
                GlobalWidgets.showBackDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                                  selected:
                                      _filtro.contains(_categorias[i].nombre),
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
                            runSpacing: 20,
                            children: _productos.map((e) {
                              return ProductoView(
                                producto: e,
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ProductoEdit(
                                      producto: e,
                                      controller: widget.controller,
                                      usuario: widget.usuario,
                                    );
                                  })).then((value) {
                                    if (value != null) {
                                      _cargar();
                                    }
                                  });
                                },
                              );
                            }).toList()),
                      ),
                    ),
                  ],
                ),
              )),
          floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProductoForm(
                      usuario: widget.usuario,
                      controller: ProductoController(usuario: widget.usuario),
                    );
                  })).then((value) => {if (value != null) _cargar()}),
              child: const Icon(Icons.add)),
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
