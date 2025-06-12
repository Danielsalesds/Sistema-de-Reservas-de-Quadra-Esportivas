import 'package:clube/ui/pages/reservas/ListarReservasScreen.dart';
import 'package:clube/ui/widgets/CardAdmin.dart';
import 'package:clube/ui/widgets/CustomBottomBar.dart';
import 'package:clube/ui/widgets/CustomFAB.dart';
import 'package:clube/ui/widgets/ReservaHojeWidget.dart';
import 'package:clube/ui/widgets/WelcomeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/AuthService.dart';
import '../../../services/FirestoreService.dart';
import '../../../services/ThemeService.dart';
import '../../../theme/AppColors.dart';

class HomeMembro extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const HomeMembro({super.key, required this.onThemeChanged});

  @override
  HomeMembroState createState() => HomeMembroState();
}

class HomeMembroState extends State<HomeMembro> {
  bool _isDarkMode = true;
  final double paddingCardH = 14;
  final double paddingCardV = 5;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    bool isDark = await ThemeService.getTheme();
    setState(() => _isDarkMode = isDark);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.cardColor,
        elevation: 0,
        title: Text(
          "Home",
          style: TextStyle(color: colors.textColor),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: _isDarkMode
                ? const Icon(Icons.light_mode, color: Colors.white)
                : const Icon(Icons.dark_mode),
            onPressed: () {
              setState(() => _isDarkMode = !_isDarkMode);
              widget.onThemeChanged(_isDarkMode);
              ThemeService.saveTheme(_isDarkMode);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: colors.iconColor,
            onPressed: () async {
              final auth = Provider.of<AuthService>(context, listen: false);
              try {
                await auth.signOut();
              } catch (e) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(index: 0),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WelcomeCard(),
          const SizedBox(height: 8),
          
          
          buildCardMembro(
            context,
            title: "Minhas Reservas",
            subtitle: "Confira todas as suas reservas",
            icon: Icons.list_alt_outlined,
            destination: const ListarReservasScreen(),
          ),
          
          const SizedBox(height: 16),
          // Seção de reservas do dia atual
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingCardH),
            child: Text(
              "Reservas de Hoje",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.textColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: _buildReservasHoje(),
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReservasHoje() {
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    final auth = Provider.of<AuthService>(context, listen: false);
    final userId = auth.getCurrentUser();
    final colors = Theme.of(context).extension<AppColors>()!;

    return StreamBuilder<QuerySnapshot>(
      stream: firestore.getReservasDoUsuarioHoje(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingCardH),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_available,
                      size: 64,
                      color: colors.textColor.withOpacity(0.3),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nenhuma reserva para hoje',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: colors.textColor.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Que tal fazer uma reserva?',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: paddingCardH),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            return ReservaHojeWidget(
              reserva: doc,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListarReservasScreen(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Padding buildCardMembro(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget destination,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingCardH,
        vertical: paddingCardV,
      ),
      child: CardAdmin(
        titulo: title,
        text1: subtitle,
        icon: icon,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        },
      ),
    );
  }
}