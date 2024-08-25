import 'package:flutter/material.dart';

class BenefitList extends StatelessWidget {
  final List<Map<String, dynamic>> benefits;

  const BenefitList({
    super.key,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: benefits.length,
      itemBuilder: (context, index) {
        final benefit = benefits[index];
        print(benefit['descripcion']);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              benefit['nombre'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(benefit['descripcion'] ?? 'Sin descripción'),
            trailing: Text("\$${benefit['valor']}"),
            onTap: () {
              // Acción cuando se toca el beneficio
            },
          ),
        );
      },
    );
  }
}
