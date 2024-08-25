import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../widgets/benefits_list.dart';
import '../widgets/crud_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> benefits = [];

  @override
  void initState() {
    super.initState();
    _loadBenefits();
  }

  Future<void> _loadBenefits() async {
    try {
      final fetchedBenefits = await apiService.getBenefits();
      setState(() {
        benefits = fetchedBenefits;
      });
    } catch (e) {
      print("Error al cargar beneficios: $e");
    }
  }

  Future<void> _createBenefit() async {
    final newBenefit = {
      "nombre": "Nuevo Beneficio",
      "descripcion": "Descripción del beneficio",
      "valor": 1500,
      "activo": true,
      "categoria": "Categoría"
    };
    try {
      await apiService.createBenefit(newBenefit);
      _loadBenefits(); // Recargar la lista después de crear
    } catch (e) {
      print("Error al crear beneficio: $e");
    }
  }

  Future<void> _updateBenefit(String id) async {
    final updatedBenefit = {
      "nombre": "Beneficio Actualizado",
      "descripcion": "Descripción actualizada del beneficio",
      "valor": 2000,
      "activo": false,
      "categoria": "Nueva Categoría"
    };
    try {
      await apiService.updateBenefit(id, updatedBenefit);
      _loadBenefits(); // Recargar la lista después de actualizar
    } catch (e) {
      print("Error al actualizar beneficio: $e");
    }
  }

  Future<void> _deleteBenefit(String id) async {
    try {
      await apiService.deleteBenefit(id);
      _loadBenefits(); // Recargar la lista después de eliminar
    } catch (e) {
      print("Error al eliminar beneficio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Beneficios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CrudButton(
                  label: 'Crear',
                  icon: Icons.add,
                  onPressed: _createBenefit, // Llamar a la función para crear
                ),
                CrudButton(
                  label: 'Leer',
                  icon: Icons.read_more,
                  onPressed: _loadBenefits, // Recargar la lista de beneficios
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CrudButton(
                  label: 'Actualizar',
                  icon: Icons.update,
                  onPressed: benefits.isNotEmpty
                      ? () => _updateBenefit(benefits[0]['_id'])
                      : () {}, // Función vacía si no hay beneficios
                ),
                CrudButton(
                  label: 'Eliminar',
                  icon: Icons.delete,
                  onPressed: benefits.isNotEmpty
                      ? () => _deleteBenefit(benefits[0]['_id'])
                      : () {}, // Función vacía si no hay beneficios
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BenefitList(benefits: benefits),
            ),
          ],
        ),
      ),
    );
  }
}
