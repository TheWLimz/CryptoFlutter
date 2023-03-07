import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyek_6/blocs/portfolio_bloc/portfolios_bloc.dart';
import 'package:proyek_6/models/portfolio_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../pages/portfolio_page.dart';



class MarketDetailPage extends StatelessWidget {
  final String slug;
  final double hourlyChange;
  final double dailyChange;
  final String name;
  final double totalPrice;
  MarketDetailPage({Key? key, required this.slug, 
  required this.dailyChange,
   required this.hourlyChange,
   required this.name,
   required this.totalPrice
   }) :super(key : key);

 WebViewController controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold(
        appBar: AppBar(title : Text('$slug/USD'), centerTitle: true, backgroundColor: Colors.black,),
        body : ListView(
          children: [
            Container(
              padding : const EdgeInsets.all(8),
              height : 400,
              width: 400,
              child: WebViewWidget(controller : controller..loadRequest(Uri.parse('https://www.tradingview.com/chart/?symbol=BITSTAMP%3A${slug}USD')), )
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Hourly Change',  style: TextStyle(fontWeight: FontWeight.w700)),
                    Text(
                           hourlyChange.toStringAsFixed(4),
                            style: TextStyle(
                                color:
                                    (hourlyChange < 0)
                                        ? Colors.red
                                        : Colors.green,
                                fontSize: 22,
                                fontWeight: FontWeight.w900)),
                  ],
                ),
                    Column(
                      children: [
                        const Text('Daily Change', style : TextStyle(fontWeight: FontWeight.w700)),
                        Text(
                         dailyChange.toStringAsFixed(4),
                            style: TextStyle(
                                color: (dailyChange < 0)
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 22,
                                fontWeight: FontWeight.w900)),
                      ],
                    ),
              ],
            )
            
          ],
        ),

        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: FloatingActionButton.extended(
            onPressed: (){
              PortfolioModel portfolio = PortfolioModel(
                 id : FirebaseFirestore.instance.collection("porfolios").id,
                 name : name,
                 totalPrice: totalPrice,
                 change : hourlyChange,
                 lots : 1
              );
              context.read<PortfoliosBloc>().add(AddPortfolios(portfolios: portfolio));
              Navigator.push(context, MaterialPageRoute(builder : (context) => PortfolioPage()));
            },
            label : const Text('Trade', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            backgroundColor: Colors.black,
        
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      )
    );
  }
}