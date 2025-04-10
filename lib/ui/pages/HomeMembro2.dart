import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/AuthService.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomBottomBar.dart';

class HomeMembro2 extends StatefulWidget {
  @override
  _HomeMembro2State createState() => _HomeMembro2State();
}

class _HomeMembro2State extends State<HomeMembro2> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Floating Action Button Pressed");
        },
        elevation: 6,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard("Minhas Reservas", "Veja e gerencie suas reservas.", _navegarParaMinhasReservas),
            SizedBox(height: 16),
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
        color: Color(0xFFA7C7E7),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              Align(
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