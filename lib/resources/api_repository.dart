import '../models/cep_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<CepModel> fetchCepList(String cep) {
    return _provider.fetchCEPList(cep);
  }
}

class NetworkError extends Error {}
