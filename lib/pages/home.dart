import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:proyek_6/data.dart';
import 'package:proyek_6/services/notification_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const TextStyle textTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  late User? _currentUser;
  
  @override
  void initState(){
    _currentUser = user;
    super.initState();
  }
   
 
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body : CustomScrollView(
          slivers: [
            
            SliverToBoxAdapter(
              child : Container(
                padding : const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.1,
                width : MediaQuery.of(context).size.width,
                child : Column(
                  children: [
                  Align(
                     alignment : Alignment.topLeft,
                      child : Text( 'Hi, ${_currentUser!.displayName}', style: HomePage.textTitleStyle,)
                    ),
                  const SizedBox(height : 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child : const Text('What do you wanna do today?')..style
                  ),
    
                  ],
                )
              )
            ),

            SliverToBoxAdapter(
              child: Container(
                padding : const EdgeInsets.all(8),
               height : MediaQuery.of(context).size.height * 0.4,
               child: ListView(
                   scrollDirection: Axis.horizontal,
                   shrinkWrap: true,
                   children: homeCardItem.entries.map<Widget>((e) {
                     return InkWell(
                      hoverColor: Colors.grey[800],
                      onTap: (){
                        const NotificationResponse response = NotificationResponse(
                          notificationResponseType: NotificationResponseType.selectedNotification,
                          id: 0,
                          actionId: "test",
                          input : "test",
                          payload: "data"
                        );
                       NotificationService.notificationResponse(response);
                      },
                       child: Card(
                         child: SizedBox(
                          width: 210,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              e.value..height,
                              Container(
                                padding : const EdgeInsets.all(8),
                                child: Align(
                                  alignment : Alignment.centerLeft,
                                  child: Text(e.key, style : const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                                  ))
                                )
                            ],
                          ),
                         ),
                       ),
                     );
                   }).toList(),               
            ),
            )
        ),

        SliverToBoxAdapter(
          child : Container(
            padding : const EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * 0.38, 
          )
        )
        ],
        )
      ),
    );
  }
}