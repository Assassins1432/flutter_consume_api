import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<List<Map<String, dynamic>>> getBenefits() async {
    final response = await http.get(Uri.parse('$baseUrl/beneficios'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Error al obtener beneficios');
    }
  }

  Future<void> createBenefit(Map<String, dynamic> benefit) async {
    final response = await http.post(
      Uri.parse('$baseUrl/beneficios'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(benefit),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear beneficio');
    }
  }

  Future<void> updateBenefit(String id, Map<String, dynamic> benefit) async {
    final response = await http.put(
      Uri.parse('$baseUrl/beneficios/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(benefit),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar beneficio');
    }
  }

  Future<void> deleteBenefit(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/beneficios/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar beneficio');
    }
  }
}
