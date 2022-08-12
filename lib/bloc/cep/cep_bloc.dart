import 'package:bloc/bloc.dart';
import 'package:myapp/bloc/cep/cep_event.dart';
import 'package:myapp/bloc/cep/cep_state.dart';
import '../../resources/api_repository.dart';

class CepBloc extends Bloc<CepEvent, CepState> {
  CepBloc() : super(CepInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCep>((event, emit) async {
      try {
        emit(CepLoading());
        final mList = await _apiRepository.fetchCepList();
        emit(CepLoaded(mList));
        if (mList.error != null) {
          emit(CepError(mList.error));
        }
      } on NetworkError {
        emit(CepError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
