import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';
import 'package:miscelanea_diego/app/data/model/POS/venta.dart';
import 'package:miscelanea_diego/app/global_widgets/global_widgets.dart';

class VentaView extends StatelessWidget {
  const VentaView({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    List<Venta> ventas = ticket.ventas;
    return Scaffold(
      appBar:
          GlobalWidgets.regresarAppBar(context, 'Ver ticket # ${ticket.key}'),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text(
            'Informacion general',
            style: TextStyle(fontSize: 25),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total: ${ticket.total}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Subtotal: ${ticket.subtotal}',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Efectivo: ${ticket.efectivo}',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Cambio: ${ticket.cambio}',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Fecha: ${ticket.fecha}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const Divider(height: 10),
          const Text(
            'Productos',
            style: TextStyle(fontSize: 20),
          ),
          const Divider(height: 20),
          Expanded(
              child: ListView.builder(
                  itemCount: ventas.length,
                  itemBuilder: (c, i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SKU:${ventas[i].producto.sku}'),
                                Text(
                                  'Nombre:${ventas[i].producto.nombre}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Precio: ${ventas[i].precio}')
                              ],
                            ),
                            ListTile(
                              leading: Text(
                                ventas[i].cantidad.round().toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                              title: Text('Subtotal\n${ventas[i].subtotal}'),
                              trailing: Text(
                                'Total\n${ventas[i].total}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
