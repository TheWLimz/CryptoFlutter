import 'package:flutter/widgets.dart';
import 'package:proyek_6/models/crypto_model.dart';
import 'package:proyek_6/pages/markets_page.dart';
import 'package:proyek_6/data.dart';

class SearchBarProvider with ChangeNotifier{
  List<CryptoModel> _searchResults = [];

  List<CryptoModel> get searchResults => _searchResults;

  Future<void> filterKeyword(String enteredKeyword) async {
    if (enteredKeyword.isEmpty){
      _searchResults = await MarketApi.getAllData();  
      notifyListeners();    
    }
    else{
      List <CryptoModel> temp = await MarketApi.getAllData();
      _searchResults = temp.where((searchValue) => searchValue.name.contains(enteredKeyword.toTitleCase())).toList();
      notifyListeners();
    }
  }

}