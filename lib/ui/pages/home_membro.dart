import 'package:flutter/material.dart';

class HomeMembro extends StatefulWidget {
  @override
  _HomeMembroState createState() => _HomeMembroState();
}

class _HomeMembroState extends State<HomeMembro> {
  List<Map<String, dynamic>> quadras = [
    {'nome': 'Quadra 1', 'reservado': false},
    {'nome': 'Quadra 2', 'reservado': true},
    {'nome': 'Quadra 3', 'reservado': false},
    {'nome': 'Quadra 4', 'reservado': false},
  ];

  void _toggleReserva(int index) {
    setState(() {
      quadras[index]['reservado'] = !quadras[index]['reservado'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Membro'),
        backgroundColor: const Color(0xffa7c7e7),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Nome do Membro"),
              accountEmail: Text("email@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.blueAccent),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Sobre"),
              onTap: () {
                // Implementar navegação para a tela de Sobre
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              onTap: () {
                // Implementar lógica de logout
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Minhas Reservas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildQuadraList(true),
            SizedBox(height: 20),
            Text("Quadras Disponíveis", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildQuadraList(false),
          ],
        ),
      ),
    );
  }

  Widget _buildQuadraList(bool reservado) {
    List<Map<String, dynamic>> filtradas =
    quadras.where((quadra) => quadra['reservado'] == reservado).toList();
    return filtradas.isEmpty
        ? Center(child: Text(reservado ? "Nenhuma reserva encontrada" : "Nenhuma quadra disponível"))
        : Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filtradas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                filtradas[index]['nome'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () => _toggleReserva(quadras.indexOf(filtradas[index])),
                style: ElevatedButton.styleFrom(
                  backgroundColor: reservado ? Colors.redAccent : Colors.green,
                ),
                child: Text(
                  reservado ? 'Cancelar' : 'Reservar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}