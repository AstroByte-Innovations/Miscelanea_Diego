import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 40,
                            runSpacing: 20,
                            children: _productos.map((e) {
                              return ProductoView(producto: e);
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

class ProductoView extends StatelessWidget {
  const ProductoView({super.key, required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      child: GestureDetector(
                        onTap: () {},
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
                      )),
                ))
              ],
            )),
      ),
    );
  }
}
