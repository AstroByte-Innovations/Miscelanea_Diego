import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_screen.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/widget/producto_form.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen(
      {super.key, required this.usuario, required this.controller});
  final Usuario usuario;
  final ProductoController controller;

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  List<Producto> _productos = [];

  Future<void> _cargar() async {
    _productos = await widget.controller.cargarProductos();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cargar();
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
                          controller:
                              CategoriaController(usuario: widget.usuario),
                        );
                      })),
                  icon: const Icon(Icons.category_rounded)),
              const SizedBox(width: 10),
              IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view))
            ],
          ),
          body: PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
                _showBackDialog();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: _productos.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(_productos[index].nombre),
                              ),
                            ),
                          );
                        },
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

  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea salir?'),
          content: const Text(
            'Los cambios que no haya guardado se perderán.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Salir'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
