import 'package:clube/ui/pages/reservas/ListarReservasScreen.dart';
import 'package:clube/ui/pages/membros/ListarMembros.dart';
import 'package:clube/ui/widgets/CardAdmin.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:clube/ui/widgets/WelcomeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/AuthService.dart';
import '../../../services/ThemeService.dart';
import '../../../theme/AppColors.dart';
import '../quadras/ListarQuadras.dart';

class HomeAdmin extends StatefulWidget{
  final Function(bool) onThemeChanged;
  const HomeAdmin({super.key, required this.onThemeChanged});
  @override
  State<StatefulWidget> createState() => HomeAdminState();

}
class HomeAdminState extends State<HomeAdmin>{
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

  final double paddingCardH = 14;
  final double paddingCardV = 5;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar:
        AppBar(
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
          ],
        ),
      bottomNavigationBar: const CustomBottomBar(index:0),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          const WelcomeCard(),
          const SizedBox(height: 5),
          buildCardAdmin(
              context,
              "Gerenciar quadras",
              "Adicione, edite ou desative quadras.",
              Icons.assignment,
              const ListarQuadras()
          ),
          buildCardAdmin(
              context,
              "Gerenciar associados",
              "Adicione ou remova associados.",
              Icons.person_add_outlined,
              const ListarMembro()
          ),
          buildCardAdmin(
              context,
              "Fazer reserva",
              "Reserve quadras sem restrições.",
              Icons.sports_soccer_outlined,
              const ListarReservasScreen()
          ),
        ],
      ),

    );
  }

  Padding buildCardAdmin(BuildContext context, String title, String text,IconData icon, Widget classe) {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingCardH, vertical: paddingCardV),
          child: CardAdmin(
            titulo: title,
            text1: text,
            icon: icon,
            onTap: () {
              // Exemplo de rota
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => classe), // ou outra tela
              );
            },
          ),
        );
  }

}