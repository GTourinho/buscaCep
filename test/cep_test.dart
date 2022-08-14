import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/bloc/cep/blocs.dart';
import 'package:myapp/models/cep_model.dart';

main() {
  blocTest<CepBloc, CepState>(
    'Emits [CepSaved] when [SaveCep] is added',
    build: () => CepBloc(),
    act: (bloc) async {
      bloc.add(SaveCep(
          cepModel: CepModel(
              bairro: 'Bairro',
              cep: '12345678',
              complemento: 'Complemento',
              localidade: 'Localidade',
              logradouro: 'Logradouro',
              uf: 'UF',
              ibge: 'IBGE',
              gia: 'GIA',
              ddd: 'DDD',
              siafi: 'SIAFI')));
    },
    verify: (bloc) async {
      expect(bloc.state, CepSaving());
    },
  );

  blocTest<CepBloc, CepState>(
    'Emits [CepLoading] when [GetCep] is added',
    build: () => CepBloc(),
    act: (bloc) async {
      bloc.add(const GetCep(cep: '12345678'));
    },
    verify: (bloc) async {
      expect(bloc.state, CepLoading());
    },
  );
}
