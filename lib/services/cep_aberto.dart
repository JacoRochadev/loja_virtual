import 'dart:io';
import 'package:dio/dio.dart';
import 'package:loja_virtual/models/cep_aberto_adress.dart';

const token = '38270518bdc99a49ed63d0eeaa6e3e58';

class CepAbertoService {
  Future<CepAbertoAdress> getAdressFromCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    final endpoint =
        Uri.parse('https://www.cepaberto.com/api/v3/cep?cep=$cleanCep');
    final Dio dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';
    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint.toString());

      if (response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final CepAbertoAdress address = CepAbertoAdress.fromMap(response.data);

      return address;
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP $e');
    }
  }
}
