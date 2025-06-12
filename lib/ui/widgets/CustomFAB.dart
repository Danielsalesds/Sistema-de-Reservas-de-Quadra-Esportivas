import 'package:flutter/material.dart';

import '../../theme/AppColors.dart';
import '../pages/reservas/ReservaQuadraScreen.dart';

class CustomFAB extends StatelessWidget{
  // final VoidCallback onPressed;
  final String? heroTag;

  const CustomFAB({
    super.key,
    // required this.onPressed,
    this.heroTag,
  });
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
      return FloatingActionButton(
        heroTag: null,
        onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ReservaQuadraScreen()),
        );
    },
        elevation: 6,
        backgroundColor: colors.cardColor,
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        child: Icon(Icons.add, color:colors.iconColor),
      );
    }
  }