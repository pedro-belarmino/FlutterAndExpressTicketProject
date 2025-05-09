import 'package:flutter/material.dart';
import 'register_ticket_screen.dart';
import 'view_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingressos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterTicketScreen(),
                    ),
                  ),
              child: const Text('Pegar Ingresso'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewListScreen()),
                  ),
              child: const Text('Ver Lista por Área'),
            ),
          ],
        ),
      ),
    );
  }
}
