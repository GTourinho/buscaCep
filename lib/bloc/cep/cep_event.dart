import 'package:equatable/equatable.dart';

abstract class CepEvent extends Equatable {
  const CepEvent();

  @override
  List<Object> get props => [];
}

class GetCep extends CepEvent {
  final String cep;
  const GetCep({required this.cep});
}
