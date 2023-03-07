import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proyek_6/models/portfolio_model.dart';
import 'package:proyek_6/services/repository.dart';

part 'portfolios_event.dart';
part 'portfolios_state.dart';

class PortfoliosBloc extends Bloc<PortfoliosEvent, PortfoliosState> {


  PortfoliosBloc() : super(PortfoliosInitial()) {
    on<ShowPortfolios>((event, emit) async {  
        List<PortfolioModel> portfolios = await PortfolioRepos.getAllPortfolios();
        emit(PortfoliosLoaded(portfolios: portfolios)); 
    });

    on<AddPortfolios>((event, emit) async {
       if (state is PortfoliosLoaded){
         List<PortfolioModel> portfolios = await PortfolioRepos.getAllPortfolios();
         PortfolioModel data = PortfolioModel(
           id : event.portfolios.id,
           name: event.portfolios.name,
           change: event.portfolios.change,
           lots : event.portfolios.lots,
           totalPrice : event.portfolios.totalPrice
         );
         await PortfolioRepos.addPortfolios(data);
        emit(PortfoliosLoaded(portfolios: portfolios));
       }
    });

    on<DeletePortfolios>((event, emit) async {
       List<PortfolioModel> portfolios = await PortfolioRepos.getAllPortfolios();
       if(state is PortfoliosLoaded){
         await PortfolioRepos.removePortfolios(event.portfolios.id);
         emit(PortfoliosLoaded(portfolios: portfolios));
       }
    });
  }
}
