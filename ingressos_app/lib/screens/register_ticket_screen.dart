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

      if (!mounted) {
        return;
      }

      final snackBar = SnackBar(
        content: Text(success ? 'Ingresso cadastrado!' : 'Erro ao cadastrar'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (success) Navigator.pop(context);
    }
  }

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  bool isValidCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    if (cpf.length != 11 || RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    List<int> digits = cpf.split('').map(int.parse).toList();

    // Primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += digits[i] * (10 - i);
    }
    int firstVerifier = (sum * 10) % 11;
    if (firstVerifier == 10) firstVerifier = 0;
    if (firstVerifier != digits[9]) return false;

    // Segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += digits[i] * (11 - i);
    }
    int secondVerifier = (sum * 10) % 11;
    if (secondVerifier == 10) secondVerifier = 0;
    if (secondVerifier != digits[10]) return false;

    return true;
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
                keyboardType: TextInputType.number,
                onChanged: (v) => cpf = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o CPF';
                  return isValidCPF(v) ? null : 'CPF inválido';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => email = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe o email';
                  return isValidEmail(v) ? null : 'Email inválido';
                },
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
