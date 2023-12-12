import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_controller.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/widgets/confirm_screen.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/widgets/producto_find.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/widgets/producto_find_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/categoria_controller.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class POSScreen extends StatefulWidget {
  final Usuario usuario;
  final PosController controller;
  final ProductoController controllerProducto;
  const POSScreen(
      {super.key,
      required this.usuario,
      required this.controller,
      required this.controllerProducto});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final TextEditingController _barcodeController = TextEditingController();

  List<Producto> carrito = [];
  Map<String, List<Producto>> productos = {};
  double? descuento;
  List<Producto> productosInvetario = [];

  Future<void> _cargarProductos() async {
    productosInvetario = await widget.controllerProducto.cargarProductos();
    setState(() {});
  }

  void cargar() {
    productos.clear();
    for (var element in carrito) {
      if (productos.containsKey(element.sku)) {
        productos[element.sku]!.add(element);
      } else {
        productos[element.sku] = [element];
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargar();
    _cargarProductos();
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
          title: const Text('Punto de venta'),
          //actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.home))],
        ),
        body: PopScope(
          canPop: false,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF0EFF4),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _barcodeController,
                      onSubmitted: (value) {
                        Producto? producto = widget.controller
                            .obtenerProductoSKU(value, productosInvetario);
                        if (producto != null) {
                          carrito.add(producto);
                          cargar();
                          succes(value);
                        } else {
                          error(value);
                        }
                        _barcodeController.text = "";
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
                  const SizedBox(width: 20),
                  IconButton(
                      onPressed: () => startBarcodeScanStream(),
                      icon: const Icon(Icons.barcode_reader)),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.add_shopping_cart_outlined)),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.one_x_mobiledata))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, i) {
                    String sku = productos.keys.elementAt(i);
                    List<Producto> items = productos[sku]!;
                    int cantidadTotal = items.length;
                    double precio = items[0].precio;
                    return ListTile(
                        onLongPress: () {
                          int index = carrito
                              .indexWhere((producto) => producto.sku == sku);
                          if (index != -1) {
                            carrito.removeAt(index);
                            cargar();
                          }
                          productoEliminado(sku);
                        },
                        leading: Text(
                          (cantidadTotal > 99)
                              ? '+99 X'
                              : '${cantidadTotal.toString()} x',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[0].sku,
                              style: const TextStyle(fontSize: 10),
                            ),
                            Text(items[0].nombre),
                            Text(
                              '\$ ${items[0].precio.toString()}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        trailing: Text(
                          '\$ ${(cantidadTotal * precio).toString()}',
                          style: const TextStyle(fontSize: 20),
                        ));
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 15, left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFF0EFF4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subtotal: \$ ${widget.controller.subtotal(carrito)}'),
                  Row(
                    children: [
                      const Icon(Icons.discount),
                      const SizedBox(width: 10),
                      Text('Descuento: ${descuento ?? ''}'),
                      (descuento != null)
                          ? IconButton(
                              onPressed: () async {
                                descuento =
                                    await mostrarDescuentoDialog(context);
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit))
                          : TextButton(
                              onPressed: () async {
                                descuento =
                                    await mostrarDescuentoDialog(context);
                                setState(() {});
                              },
                              child: const Text('Agregar un descuento'),
                            ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        double total =
                            widget.controller.total(carrito, descuento);
                        if (carrito.isNotEmpty) {
                          double? efectivo =
                              await mostrarEfectivoDialog(context, total);

                          if (efectivo != null) {
                            if (efectivo >= total) {
                              double cambio = efectivo - total;
                              Ticket ticket = widget.controller.generarTicket(
                                  productos,
                                  carrito,
                                  widget.controller.subtotal(carrito),
                                  widget.controller.total(carrito, descuento),
                                  efectivo,
                                  cambio);
                              await Future.delayed(
                                  const Duration(milliseconds: 500));

                              finalizar(ticket);
                            } else {
                              errorVenta('Efectivo insuficiente.',
                                  'Favor de ingresar un monto de efectivo igual o mayor al vaor de la compra');
                            }
                          }
                        } else {
                          errorVenta('Error al registrar la venta',
                              'No se puede completar la venta sin productos en el carrito.');
                        }
                      },
                      child: Text(
                          '${carrito.length} Productos = Total: \$ ${widget.controller.total(carrito, descuento)}'),
                    ),
                  ),
                ],
              ),
            )
          ]),
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            _showBackDialog();
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                return ProductoFind(
                  carrito: carrito,
                  controller: ProductoFindController(),
                  controllerProducto:
                      ProductoController(usuario: widget.usuario),
                  controllerCategoria:
                      CategoriaController(usuario: widget.usuario),
                  usuario: widget.usuario,
                );
              })).then((value) {
                if (value != null) {
                  carrito = value;
                  cargar();
                }
              });
            },
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<double?> mostrarEfectivoDialog(
      BuildContext context, double total) async {
    return showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        double? montoIngresado;

        return AlertDialog(
          title: const Text('Ingresar Monto en Efectivo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total a pagar: \$${total.toStringAsFixed(2)}'),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  hintText: 'Ingrese el monto',
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    montoIngresado = double.tryParse(value);
                  } else {
                    montoIngresado = null;
                  }
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(montoIngresado);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<double?> mostrarDescuentoDialog(
    BuildContext context,
  ) async {
    return showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        double? montoDescuento;

        return AlertDialog(
          title: const Text('Ingresar Descuento en Monto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ingresar un descuento}'),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monto de Descuento',
                  hintText: 'Ingrese el monto de descuento',
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    montoDescuento = double.tryParse(value);
                  } else {
                    montoDescuento = null;
                  }
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(montoDescuento);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void finalizar(Ticket ticket) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
      return ConfirmacionScreen(
        ticket: ticket,
        usuario: widget.usuario,
        controller: widget.controller,
        productoController: widget.controllerProducto,
      );
    }));
  }

  Future<void> startBarcodeScanStream() async {
    String barCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
    if (barCode != '-1') {
      Producto? producto =
          widget.controller.obtenerProductoSKU(barCode, productosInvetario);
      if (producto != null) {
        carrito.add(producto);
        cargar();
        succes(barCode);
      } else {
        error(barCode);
      }
    }
  }

  void error(String sku) {
    ElegantNotification.error(
            width: 400,
            notificationPosition: NotificationPosition.topRight,
            animation: AnimationType.fromLeft,
            title: const Text('Producto no encontrado'),
            description: Text('El producto $sku no existe en la base de datos'))
        .show(context);
  }

  void productoEliminado(String sku) {
    ElegantNotification.info(
            width: 400,
            notificationPosition: NotificationPosition.topLeft,
            animation: AnimationType.fromLeft,
            title: const Text('Producto eliminado'),
            description: Text('El producto $sku ha sido eliminado del carrito'))
        .show(context);
  }

  void errorVenta(String title, String des) {
    ElegantNotification.error(
      width: 400,
      notificationPosition: NotificationPosition.topRight,
      animation: AnimationType.fromLeft,
      title: Text(title),
      description: Text(des),
    ).show(context);
  }

  void succes(String sku) {
    ElegantNotification.success(
      toastDuration: const Duration(seconds: 2),
      width: 400,
      notificationPosition: NotificationPosition.topLeft,
      animation: AnimationType.fromLeft,
      title: const Text('Producto agregado'),
      description: Text('Producto $sku agregado'),
      onDismiss: () {},
    ).show(context);
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
