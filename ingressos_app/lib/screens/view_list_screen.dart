import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../services/ticket_service.dart';

class ViewListScreen extends StatefulWidget {
  const ViewListScreen({super.key});

  @override
  State<ViewListScreen> createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  String area = 'Pista';
  List<Ticket> tickets = [];

  void loadTickets() async {
    final list = await TicketService.getTicketsByArea(area);
    setState(() => tickets = list);
  }

  @override
  void initState() {
    super.initState();
    loadTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Ingressos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField(
              value: area,
              items:
                  ['Pista', 'Camarim']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged:
                  (v) => setState(() {
                    area = v!;
                    loadTickets();
                  }),
              decoration: const InputDecoration(labelText: 'Área'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return ListTile(
                  title: Text(ticket.name),
                  subtitle: Text('${ticket.email} | ${ticket.cpf}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
