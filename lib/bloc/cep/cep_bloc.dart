import 'package:bloc/bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:myapp/bloc/cep/cep_event.dart';
import 'package:myapp/bloc/cep/cep_state.dart';
import '../../resources/api_repository.dart';

class CepBloc extends Bloc<CepEvent, CepState> {
  CepBloc() : super(CepInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    final LocalStorage storage = LocalStorage('some_key');

    on<GetCep>((event, emit) async {
      try {
        emit(CepLoading());
        final mList = await apiRepository.fetchCepList(event.cep);
        emit(CepLoaded(mList));
        if (mList.error != null) {
          emit(CepError(mList.error));
        }
        if (mList.cep == null) {
          emit(const CepError(
              "Não conseguimos localizar seu endereço, verifique se as informações passadas estão corretas"));
        }
      } on NetworkError {
        emit(
          const CepError(
              "Falha ao buscar dados. Verifique sua conexão com a internet"),
        );
      }
    });

    on<SaveCep>((event, emit) async {
      storage.setItem('cep', event.cepModel);
      emit(CepSaved(event.cepModel));
    });
  }
}
