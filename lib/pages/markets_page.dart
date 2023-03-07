import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:proyek_6/models/crypto_model.dart';
import 'package:http/http.dart' as http;
import 'package:proyek_6/providers/search_bar_provider.dart';
import 'package:proyek_6/secondary_page/markets_detail_page.dart';
import 'package:proyek_6/services/api_services.dart';

import '../services/search_delegate.dart';


class MarketApi{
  static Future<List<CryptoModel>> getAllData() async {
      Uri url = Uri.parse(dotenv.env['BASE_CRYPT_URL']!);
      var response = await http
        .get(url, headers: {
          "Accept": "application/json",
          "X-CMC_PRO_API_KEY": dotenv.env['CRYPT']!
          });
     try{  
      if (response.statusCode == 200){
         var result = json.decode(response.body);
      var apiResponse = ApiListStatus<CryptoModel>.fromJson(result, (list){
         List cryptoData = result['data'];
         return cryptoData.map<CryptoModel>((e) => CryptoModel.fromJson(e)).toList();
      });
       return apiResponse.data!;
      } else{
        throw Exception('There was an error');
      }
     
     } catch(e){
      print(e);
        throw Exception(e);
     }
  }

  
}



class MarketsPage extends StatelessWidget {
  MarketsPage({Key? key}) : super(key: key);
  



  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: Scaffold(
        body : NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.grey[100],
            toolbarHeight: 100,
            title: const Text("Markets",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            actions : [
              IconButton(icon: const Icon(Icons.search, size: 30,),
               onPressed: (){
                showSearch(context: context, delegate: CustomSearchDelegate());
                
              }, 
              color : Colors.black)
            ],
            elevation: 10.0,
            automaticallyImplyLeading: false,
            expandedHeight: 50,
            floating: true,
            snap: true,
          )
        ];
      },
        body: FutureBuilder<List<CryptoModel>>(
            future: MarketApi.getAllData(),
            builder : (context, snapshot){
               if (snapshot.hasData){
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const Divider(thickness: 2,),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                      
                          return MarketDetailPage(
                            slug : snapshot.data![index].symbol,
                            hourlyChange: snapshot.data![index].oneHourPercentChange,
                           dailyChange: snapshot.data![index].dayPercentChange,
                           name : snapshot.data![index].name,
                           totalPrice: snapshot.data![index].price,
                          );
                        }));
                      },
                      leading : Container(
                        padding : const EdgeInsets.all(8),
                        child : Image.network('https://s2.coinmarketcap.com/static/img/coins/64x64/${snapshot.data![index].id}.png')
                      ),
                      title: Text(snapshot.data![index].name, style : const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      subtitle: Text(snapshot.data![index].symbol, style : const TextStyle(fontSize : 18, fontWeight: FontWeight.w600)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data![index].price.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                          Text(snapshot.data![index].oneHourPercentChange.toStringAsFixed(4), style : TextStyle(
                            color : (snapshot.data![index].oneHourPercentChange < 0 ) ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w900
                          )),
                           Text(snapshot.data![index].dayPercentChange
                            .toStringAsFixed(4), style: TextStyle(
                                color: (snapshot
                                            .data![index].dayPercentChange <
                                        0)
                                    ? Colors.red
                                    : Colors.green, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    );
                  },
                );
               }
               else if (snapshot.hasError){
                return const Center(child: Text('There was An Error', style : TextStyle(fontSize: 40)));
               }
               else {
                return const Center(child : CircularProgressIndicator());
               }
            }
          ),
        )
      )
      );
  }
  

}
