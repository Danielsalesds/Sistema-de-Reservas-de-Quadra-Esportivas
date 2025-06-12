import 'package:flutter/material.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomBottomBar.dart';
import '../../widgets/CustomFAB.dart';

class HomeMembro2 extends StatefulWidget {
  const HomeMembro2({super.key});

  @override
  HomeMembro2State createState() => HomeMembro2State();
}

class HomeMembro2State extends State<HomeMembro2> {
  void _navegarParaMinhasReservas() {
    // Navegar para a tela de Minhas Reservas
  }

  void _navegarParaReservarQuadras() {
    // Navegar para a tela de Reservar Quadras
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Painel de Associado',),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard("Minhas Reservas", "Veja e gerencie suas reservas.", _navegarParaMinhasReservas),
            const SizedBox(height: 16),
            _buildCard("Reservar Quadras", "Confira e reserve uma quadra disponível.", _navegarParaReservarQuadras),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFA7C7E7),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_right_alt, color: Colors.white, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}