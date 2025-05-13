import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/AuthService.dart';
import '../../services/ThemeService.dart';
import '../../theme/AppColors.dart';
import '../widgets/CustomBottomBar.dart';
import '../widgets/CustomFAB.dart';
import 'ReservaQuadraScreen.dart';

class HomeMembro extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const HomeMembro({super.key, required this.onThemeChanged});

  @override
  HomeMembroState createState() => HomeMembroState();
}

class HomeMembroState extends State<HomeMembro> {
  bool _isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    bool isDark = await ThemeService.getTheme();
    setState(() {
      _isDarkMode = isDark;
    });
  }
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
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: colors.cardColor,
          elevation: 0,
          title: Text("Home",style: TextStyle(color:colors.textColor,),),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed:(){
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                  widget.onThemeChanged(_isDarkMode);
                  ThemeService.saveTheme(_isDarkMode);
                  },
                icon: _isDarkMode ? const Icon(Icons.light_mode, color: Colors.white,) : const Icon(Icons.dark_mode)
            ),
            IconButton(
                onPressed:() async {
                  final auth = Provider.of<AuthService>(context,listen:false);
                  try{
                    await auth.signOut();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> const AuthChecker()));
                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString()))
                    );
                  }
                },
                icon: const Icon(Icons.logout),
                color: colors.iconColor
            )
          ]
      ),
    bottomNavigationBar: const CustomBottomBar(),
      floatingActionButton: CustomFAB(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReservaQuadraScreen()),
            );
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Minhas Reservas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildQuadraList(true),
            const SizedBox(height: 20),
            const Text("Quadras Disponíveis", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildQuadraList(false),
          ],
        ),
      ),
    );
  }

  Widget _buildQuadraList(bool reservado) {
    final colors = Theme.of(context).extension<AppColors>()!;
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
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                filtradas[index]['nome'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () => _toggleReserva(quadras.indexOf(filtradas[index])),
                style: ElevatedButton.styleFrom(
                  backgroundColor: reservado ? colors.cancelBtnColor : colors.okBtnColor,
                ),
                child: Text(
                  reservado ? 'Cancelar' : 'Reservar',
                  style: TextStyle(color: colors.backgroundColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}