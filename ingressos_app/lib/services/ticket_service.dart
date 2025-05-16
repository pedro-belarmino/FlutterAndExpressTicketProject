import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ticket.dart';

const baseUrl = 'http://localhost:3000';

class TicketService {
  static Future<bool> registerTicket(Ticket ticket) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tickets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ticket.toJson()),
    );
    return response.statusCode == 201;
  }

  static Future<List<Ticket>> getTicketsByArea(String area) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tickets/${area.toLowerCase()}'),
    );
    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((e) => Ticket.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
