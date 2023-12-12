import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket_model.dart';

class VentasController {
  VentasController();
  TicketModel modelo = TicketModel();

  Future<List<Ticket>> cargarTickets() async {
    return modelo.obtenerTodosTickets();
  }
}
