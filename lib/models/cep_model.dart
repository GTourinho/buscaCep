class CepModel {
  String cep = '';
  String logradouro = '';
  String complemento = '';
  String bairro = '';
  String localidade = '';
  String uf = '';
  String ibge = '';
  String gia = '';
  String ddd = '';
  String siafi = '';
  String error = '';
  CepModel(
      {required this.cep,
      required this.logradouro,
      required this.complemento,
      required this.bairro,
      required this.localidade,
      required this.uf,
      required this.ibge,
      required this.gia,
      required this.ddd,
      required this.siafi});

  CepModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }

  CepModel.withError(String errorMessage) {
    return;
  }

  static toJsonList(List<CepModel> cepModels) {
    return cepModels.map((cepModel) => cepModel.toJson()).toList();
  }

  static fromJsonList(List<dynamic> cepModels) {
    return cepModels.map((cepModel) => CepModel.fromJson(cepModel)).toList();
  }
}
