part of 'portfolios_bloc.dart';

abstract class PortfoliosEvent extends Equatable {
  const PortfoliosEvent();

  @override
  List<Object> get props => [];
}

class ShowPortfolios extends PortfoliosEvent {
  final List<PortfolioModel> portfolios;

  const ShowPortfolios({this.portfolios = const []});

  @override 
  List<Object> get props => [portfolios];
}


class AddPortfolios extends PortfoliosEvent {
   final PortfolioModel portfolios;

  const AddPortfolios({required this.portfolios});

  @override 
  List<Object> get props => [portfolios];
}

class DeletePortfolios extends PortfoliosEvent {
  final PortfolioModel portfolios;

  const DeletePortfolios({required this.portfolios});

  @override
  List<Object> get props => [portfolios];
}
