import 'package:dio/dio.dart';
import '../models/cep_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://viacep.com.br/ws/';

  Future<CepModel> fetchCEPList(String cep) async {
    try {
      Response response = await _dio.get('$_baseUrl$cep/json');
      return CepModel.fromJson(response.data);
    } catch (error) {
      return CepModel.withError("Data not found / Connection issue");
    }
  }
}
