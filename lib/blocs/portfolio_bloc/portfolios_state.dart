part of 'portfolios_bloc.dart';

abstract class PortfoliosState extends Equatable {
  const PortfoliosState();
  
  @override
  List<Object> get props => [];
}

class PortfoliosInitial extends PortfoliosState {}

class PortfoliosLoaded extends PortfoliosState {
  final List<PortfolioModel> portfolios;

  const PortfoliosLoaded({this.portfolios = const []});

  @override 
  List<Object> get props => [portfolios];
}


