import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../services/ticket_service.dart';

class RegisterTicketScreen extends StatefulWidget {
  const RegisterTicketScreen({super.key});

  @override
  State<RegisterTicketScreen> createState() => _RegisterTicketScreenState();
}

class _RegisterTicketScreenState extends State<RegisterTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', cpf = '', email = '', area = 'Pista';

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final ticket = Ticket(name: name, cpf: cpf, email: email, area: area);
      final success = await TicketService.registerTicket(ticket);
      final snackBar = SnackBar(
        content: Text(success ? 'Ingresso cadastrado!' : 'Erro ao cadastrar'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (success) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Ingresso')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (v) => name = v,
                validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'CPF'),
                onChanged: (v) => cpf = v,
                validator: (v) => v!.isEmpty ? 'Informe o CPF' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (v) => email = v,
                validator: (v) => v!.isEmpty ? 'Informe o email' : null,
              ),
              DropdownButtonFormField(
                value: area,
                items:
                    ['Pista', 'Camarim']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (v) => setState(() => area = v!),
                decoration: const InputDecoration(labelText: 'Área'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: submit, child: const Text('Cadastrar')),
            ],
          ),
        ),
      ),
    );
  }
}
