import 'package:flutter/material.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_controller.dart';
import 'package:miscelanea_diego/app/screens/pos_screen/pos_screen.dart';
import 'package:miscelanea_diego/app/screens/productos_screen/productos_controller.dart';

class ConfirmacionScreen extends StatelessWidget {
  const ConfirmacionScreen({
    super.key,
    required this.controller,
    required this.productoController,
    required this.usuario,
    required this.ticket,
  });

  final Usuario usuario;
  final PosController controller;
  final ProductoController productoController;
  final Ticket ticket;

  void finalizar(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
      return POSScreen(
          usuario: usuario,
          controller: controller,
          controllerProducto: productoController);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade600, // Fondo de color verde claro
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      const Text(
                        '¡Venta Confirmada!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Información adicional',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monto total:\n\$ ${ticket.total}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            'Monto efectivo:\n\$ ${ticket.efectivo}',
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          const Text(
                            'Cambio:',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                          Text(
                            '\$ ${ticket.cambio}',
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      FilledButton(
                        onPressed: () => finalizar(context),
                        child: const Text('Continuar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
