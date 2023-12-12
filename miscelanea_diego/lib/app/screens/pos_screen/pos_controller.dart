import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket_model.dart';
import 'package:miscelanea_diego/app/data/model/POS/venta.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento.dart';
import 'package:miscelanea_diego/app/data/model/Productos/inventario_movimiento_model.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';
import 'package:miscelanea_diego/app/data/model/Productos/producto_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/auditoria_model.dart';
import 'package:miscelanea_diego/app/data/model/Usuarios/usuario.dart';

class PosController {
  final Usuario usuario;
  PosController({required this.usuario});
  TicketModel ticketModelo = TicketModel();
  ProductoModel productoModelo = ProductoModel();
  AuditoriaModel auditoriaModel = AuditoriaModel();
  InventarioMovimientoModel inventarioModelo = InventarioMovimientoModel();

  double subtotal(List<Producto> productos) {
    double subtotal = 0;
    for (var element in productos) {
      subtotal += element.precio;
    }
    return subtotal;
  }

  double total(List<Producto> productos, double? desc) {
    double total = 0;
    for (var element in productos) {
      total += element.precio;
    }
    if (desc != null) {
      total = total - desc;
    }

    return total;
  }

  Producto? obtenerProductoSKU(String sku, List<Producto> productos) {
    Producto? producto;
    for (Producto element in productos) {
      if (element.sku == sku) {
        producto = element;
      }
    }
    return producto;
  }

  Ticket generarTicket(
      Map<String, List<Producto>> productos,
      List<Producto> carrito,
      double subtotal,
      double total,
      double efectivo,
      double cambio) {
    List<Venta> ventas = [];
    productos.forEach((key, value) {
      double cantidad = value.length.toDouble();
      double precio = value[0].precio;
      ventas.add(Venta(
          producto: value[0],
          cantidad: cantidad,
          precio: precio,
          subtotal: (cantidad * precio),
          total: (cantidad * precio)));
    });

    for (var element in ventas) {
      double cantidadA = element.producto.cantidad;
      double cantidad = element.cantidad;
      double cantidadF = cantidadA - cantidad;
      if (cantidadF < 0) {
        cantidadF = 0;
      }

      element.producto.cantidad = cantidadF;
      if (element.producto.cantidad < 0) {
        element.producto.estado = 0;
      } else if (element.producto.cantidad > 5) {
        element.producto.estado = 2;
      } else {
        element.producto.estado = 1;
      }
      productoModelo.actualizarProducto(element.producto, element.producto.key);
      inventarioModelo.agregarMovimiento(MovimientoAlmacen(
          sku: element.producto.sku,
          nombre: element.producto.nombre,
          fecha: DateTime.now(),
          tipo: 0,
          cantidadA: cantidadA,
          cantidad: cantidad,
          cantidadF: cantidadF,
          usuario: usuario));
    }
    Ticket ticket = Ticket(
        fecha: DateTime.now(),
        cantidadProductos: carrito.length.toDouble(),
        subtotal: subtotal,
        total: total,
        efectivo: efectivo,
        cambio: cambio,
        ventas: ventas);

    auditoriaModel.agregarAuditoria(Auditoria(
        usuario: usuario,
        tipoRegistro: 'Venta',
        accion: 'Creacion',
        fecha: DateTime.now(),
        registro: 'Ticket',
        descripcion: ticket.toString()));
    ticketModelo.agregarTicket(ticket);

    return ticket;
  }
}
