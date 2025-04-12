import 'package:flutter/material.dart';

import '../widgets/CustomAppBar.dart';
import '../widgets/CustomBottomBar.dart';
import 'ReservaQuadraScreen.dart';

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
      appBar: const CustomAppBar(title: 'Home',),
      bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReservaQuadraScreen()));
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