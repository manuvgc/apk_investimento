import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class InverTextoApiService{
  final String _token = "28246|sCQSS8tFYrbTVRxRkqZ1cFGXt1orEw8p";
  Future<Map<String, dynamic>> convertePorExtenso(
    String? valor) async {
      try{
        final uri = Uri.parse(
          "https://api.invertexto.com/v1/number-to-words"
          "?token=$_token&number=$valor"
          "&language=pt");
          final response = await http.get(uri);
          if(response.statusCode == 200){
            return json.decode(response.body);
          }else{
            throw Exception(
              'Erro ${response.statusCode}: ${response.body}');
          }
      } on SocketException {
        throw Exception('Erro de conexão com a internet');
      } catch (e) {rethrow; }
    }

    Future<Map<String, dynamic>> buscaCEP(
    String? valor) async {
      try{
        final uri = Uri.parse(
          "https://api.invertexto.com/cep/$valor"
          "?token=$_token&number=$valor");
          final response = await http.get(uri);
          if(response.statusCode == 200){
            return json.decode(response.body);
          }else{
            throw Exception(
              'Erro ${response.statusCode}: ${response.body}');
          }
      } on SocketException {
        throw Exception('Erro de conexão com a internet');
      } catch (e) {rethrow; }
    }
}