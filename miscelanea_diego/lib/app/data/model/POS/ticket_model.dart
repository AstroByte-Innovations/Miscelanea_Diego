import 'package:hive_flutter/hive_flutter.dart';
import 'package:miscelanea_diego/app/data/model/POS/ticket.dart';

class TicketModel {
  Future<void> agregarTicket(Ticket ticket) async {
    final ticketsBox = await Hive.openBox<Ticket>('tickets');
    ticketsBox.add(ticket);
  }

  Future<List<Ticket>> obtenerTodosTickets() async {
    final ticketsBox = await Hive.openBox<Ticket>('tickets');
    return ticketsBox.values.toList().reversed.toList();
  }
}
