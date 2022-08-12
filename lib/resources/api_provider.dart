import 'package:dio/dio.dart';

import '../models/cep_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'https://viacep.com.br/ws/40140090/json';

  Future<CepModel> fetchCEPList() async {
    try {
      Response response = await _dio.get(_url);
      return CepModel.fromJson(response.data);
    } catch (error) {
      return CepModel.withError("Data not found / Connection issue");
    }
  }
}
