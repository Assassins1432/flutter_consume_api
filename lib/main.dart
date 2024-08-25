import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const BeneficiosApp());
}

class BeneficiosApp extends StatelessWidget {
  const BeneficiosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beneficios App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/background.jpg"), // Agrega tu imagen de fondo en assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          const HomeScreen(),
        ],
      ),
    );
  }
}
