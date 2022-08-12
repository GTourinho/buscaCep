import 'package:equatable/equatable.dart';

abstract class CepEvent extends Equatable {
  const CepEvent();

  @override
  List<Object> get props => [];
}

class GetCep extends CepEvent {}
