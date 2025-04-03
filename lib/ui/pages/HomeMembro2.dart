import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('Home Membro'),
        backgroundColor: Color(0xFFA7C7E7),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFA7C7E7)),
              accountName: Text("Nome do Membro", style: TextStyle(color: Colors.white)),
              accountEmail: Text("email@exemplo.com", style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Color(0xFFA7C7E7)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Color(0xFFA7C7E7)),
              title: Text("Sobre"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: Text("Sair"),
              onTap: () {},
            ),
          ],
        ),
      ),
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