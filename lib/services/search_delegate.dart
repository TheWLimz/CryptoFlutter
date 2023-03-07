import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_6/models/crypto_model.dart';

import '../providers/search_bar_provider.dart';
import '../secondary_page/markets_detail_page.dart';



class CustomSearchDelegate extends SearchDelegate{
   @override 
   List<Widget> buildActions(BuildContext context){
        final searchBarProvider = Provider.of<SearchBarProvider>(context);
     return [
         IconButton(
          icon : const Icon(Icons.clear),
          onPressed: (){
            String query = '';
            searchBarProvider.filterKeyword(query);
          },
         ),
     ];
   }

    @override
  Widget buildLeading(BuildContext context) {
     return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
       final searchBarProvider = Provider.of<SearchBarProvider>(context);
     for (int i = 0; i < searchBarProvider.searchResults.length; i++) {
      searchBarProvider.filterKeyword(searchBarProvider.searchResults[i].name);
    }
     List<CryptoModel> filtered = searchBarProvider.searchResults;

    return ListView.separated(
      separatorBuilder:(context, index) => const Divider(thickness: 2),
      itemCount: filtered.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                      
                          return MarketDetailPage(slug : filtered[index].symbol,hourlyChange: filtered[index].oneHourPercentChange,
                           dailyChange: filtered[index].dayPercentChange,
                           name : filtered[index].name,
                           totalPrice: filtered[index].price,
                          );
                        }));
                      },
                      leading : Container(
                        padding : const EdgeInsets.all(8),
                        child : Image.network('https://s2.coinmarketcap.com/static/img/coins/64x64/${filtered[index].id}.png')
                      ),
                      title: Text(filtered[index].name, style : const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      subtitle: Text(filtered[index].symbol, style : const TextStyle(fontSize : 18, fontWeight: FontWeight.w600)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(filtered[index].price.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                          Text(filtered[index].oneHourPercentChange.toStringAsFixed(4), style : TextStyle(
                            color : (filtered[index].oneHourPercentChange < 0 ) ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w900
                          )),
                           Text(filtered[index].dayPercentChange
                            .toStringAsFixed(4), style: TextStyle(
                                color: (filtered[index].dayPercentChange <
                                        0)
                                    ? Colors.red
                                    : Colors.green, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    );
      },
    );
   
  }

  @override
  Widget buildSuggestions(BuildContext context) {
     final searchBarProvider = Provider.of<SearchBarProvider>(context);

        for (int i = 0; i < searchBarProvider.searchResults.length; i++) {
      searchBarProvider.filterKeyword(searchBarProvider.searchResults[i].name);
    }

       return ListView.builder(
      itemCount: searchBarProvider.searchResults.length,
      itemBuilder: (context, index) {
        var result = searchBarProvider.searchResults[index];
        return ListTile(
          title: Text(result.name),
        );
      },
    );
    
  }
}