import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardAdmin extends StatefulWidget {
  final String titulo;
  final String text1;
  final IconData icon;
  final VoidCallback? onTap; 

  const CardAdmin({
    super.key,
    required this.titulo,
    required this.text1,
    required this.icon,
    this.onTap,
  });

  @override
  State<CardAdmin> createState() => CardAdminState();
}

class CardAdminState extends State<CardAdmin> {
  Color textColor = const Color(0xFF0A2F4F);
  Color textColor2 = const Color(0xFF333333);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, 
      child: Card.filled(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                          // color: textColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(widget.icon, color:  Theme.of(context).colorScheme.onPrimary, size: 30),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        widget.text1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.arrow_right_alt, color: Colors.white, size: 35)
                    ],
                  ),
                  const SizedBox(height: 5),
                  // const Row(
                  //   children: [
                  //     SizedBox(width: 300,),
                  //     Icon(Icons.arrow_right_alt, color: Colors.white, size: 40)
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
