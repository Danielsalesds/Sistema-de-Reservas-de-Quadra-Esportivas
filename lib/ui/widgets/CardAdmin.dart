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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, 
      child: Card.filled(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
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
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(widget.icon, color: Colors.white, size: 30),
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
