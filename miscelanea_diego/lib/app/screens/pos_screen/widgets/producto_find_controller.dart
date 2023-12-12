import 'package:miscelanea_diego/app/data/model/Productos/producto.dart';

class ProductoFindController {
  total(List<Producto> productos) {
    double total = 0;
    for (Producto e in productos) {
      total += e.precio;
    }
    return total;
  }
}
