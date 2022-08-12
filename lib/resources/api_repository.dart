import '../models/cep_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<CepModel> fetchCepList() {
    return _provider.fetchCEPList();
  }
}

class NetworkError extends Error {}
