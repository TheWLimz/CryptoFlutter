import 'package:flutter/material.dart';
import 'package:proyek_6/data.dart';

class ArticlePage extends StatelessWidget {
 
 final String title;
 final String publishedAt;
 final String author;
 final String description; 
 final String? imgUrl;


 const ArticlePage({Key? key, 
 required this.publishedAt, 
 required this.title, 
 required this.description, 
 required this.author,
 required this.imgUrl}) : super(key: key);
  
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.grey,),
        body : ListView(
          children: [
             imgUrl != null ? Container(
              padding : const EdgeInsets.all(5),
              child: Image.network(imgUrl!)
              )
              : Container(
                  margin: const EdgeInsets.all(15),
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey),
                ),

            const SizedBox(height : 10),
             
             Container(
              padding : const EdgeInsets.all(12),
              child : Text(title, style : const TextStyle(fontSize: 26)),
             ),

             Container(
               padding: const EdgeInsets.all(12),
               child: Text('Published on ${FormatDate(publishedAt)
                    .todayDate(
                        DateTime.parse(publishedAt))} by $author'),
             ),

             Container(
              padding : const EdgeInsets.all(12),
              child : Text(description, style : const TextStyle(fontSize: 18))
             )

          ],
        )
      ),
    );
  }
}