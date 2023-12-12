import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';
import 'package:miscelanea_diego/app/global_widgets/menu.dart';
import 'package:miscelanea_diego/app/screens/ventas_screen/ventas_controller.dart';
import 'package:miscelanea_diego/app/screens/ventas_screen/ventas_view.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen(
      {super.key, required this.controller, required this.usuario});
  final VentasController controller;
  final Usuario usuario;

  @override
  State<VentasScreen> createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  List<Ticket> tickets = [];
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  void _cargar() async {
    tickets = await widget.controller.cargarTickets();
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
        appBar: GlobalWidgets.appBar(_sideMenuKey, 'Ventas'),
        body: ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (c, i) {
              return Card(
                child: ListTile(
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return VentaView(ticket: tickets[i]);
                        })),
                    leading: Text(
                      '# ${tickets[i].key}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total: ${tickets[i].total}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Subtotal: ${tickets[i].subtotal}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Efectivo: ${tickets[i].efectivo}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Cambio: ${tickets[i].cambio}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Fecha: ${tickets[i].fecha}',
                            style: const TextStyle(fontSize: 10),
                          )
                        ]),
                    trailing:
                        Text(tickets[i].cantidadProductos.round().toString())),
              );
            }),
      ),
    );
  }
}
