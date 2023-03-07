import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proyek_6/pages/article_page.dart';
import 'package:proyek_6/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:proyek_6/data.dart';
import '../models/news_model.dart';


class NewsApi{
    static Future<List<NewsModel>> getAllNews() async {
       Uri url = Uri.parse('${dotenv.env['BASE_NEWS_URL']}${dotenv.env['API_KEY']!}');
       var response = await http.get(url);
       try {        
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var apiResponse = ApiListStatus<NewsModel>.fromJson(result, (data) {
          List news = result['articles'];
          return news.map<NewsModel>((e) => NewsModel.fromJson(e)).toList();
        });
        return apiResponse.data!;
      } else {
        throw Exception('There was an error');
      }
       } catch (e) {
         throw Exception(e);
       }      
    }
}

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);
  

   
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
              title:const Text("News", style : TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)),
              elevation: 10.0,
              automaticallyImplyLeading: false,
              expandedHeight: 50,
              floating: true,
              snap: true,
            )
          ];
        },
          body: FutureBuilder<List<NewsModel>>(
            future : NewsApi.getAllNews(),
            builder : (context, snapshot){
              if (snapshot.hasData){
                 return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder :(context,index){
                    return Container(
                        height : MediaQuery.of(context).size.height * 0.22,
                        padding : const EdgeInsets.all(5),
                        child : Card(
                          color : Colors.grey[200],
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ArticlePage(title: snapshot.data![index].title ,
                                 description: snapshot.data![index].description , 
                                 imgUrl: snapshot.data![index].urlToImage,
                                 publishedAt: snapshot.data![index].publishedAt,
                                 author : snapshot.data![index].author
                                 );
                              }));
                            },
                            leading: Image.network(snapshot.data![index].urlToImage, width: 150, ),
                            title: Text(snapshot.data![index].title, style : TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            subtitle: Text(FormatDate(
                                              snapshot.data![index].publishedAt)
                                          .todayDate(DateTime.parse(
                                              snapshot.data![index].publishedAt)), style : TextStyle(fontWeight: FontWeight.bold, color : Colors.grey[900])),
                          ),
                        )
                        );
                  }
                 );
              }
              else if(snapshot.hasError){
                 return const Center(child: Text("There was an Error", style:TextStyle(fontSize: 40)));
              }
              else{
                return const Center(child: CircularProgressIndicator());
              }
            }
          ),
        )
      ),
    );

    
  }

  
}


