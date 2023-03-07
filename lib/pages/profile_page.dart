import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyek_6/data.dart';
import 'package:proyek_6/providers/user_state_provider.dart';



class MePage extends StatelessWidget {
  MePage({Key? key}) : super(key: key);

  final TextStyle _style = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserStateProvider>(context);
    String? displayName = provider.user!.displayName;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                     color : Colors.grey[300]
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                    color: Colors.white,
                                    width: 70,
                                    height: 70,
                                    child: Center(
                                        child: FaIcon(FontAwesomeIcons.person,
                                            size: 45)))),
                            const SizedBox(
                              width: 25,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (displayName == '') ?  
                                  Column(
                                    children: [
                                      const Text('Sign in to Trade'),
                                      ElevatedButton(onPressed: (){}, child: const Text('Sign In'))
                                    ],
                                  ) :
                                 Text(displayName!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: const Text("Crypto Investor", style : TextStyle(fontWeight: FontWeight.bold, fontSize : 16)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ))),
            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Account Settings',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)))),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: accountSectionItems.entries.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final entries = accountSectionItems.entries.toList();
                      return ListTile(
                        leading: entries[index].value,
                        title: Text(entries[index].key,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        onTap: () {},
                        hoverColor: Colors.grey,
                      );
                    },
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text('Application Settings',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)))),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: applicationSectionItems.entries.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final entries = applicationSectionItems.entries.toList();
                      return ListTile(
                        leading: entries[index].value,
                        title: Text(entries[index].key,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: <Widget>() {
                          switch (entries[index].key) {
                            case 'GeoLocation':
                              return const Text(
                                  'Activate it for more accurate location results');
                            case 'Picture Quality':
                              return const Text('Adjust the image quality');
                            case 'Clean Cache':
                              return const Text(
                                  'Clean all cached data and sign you out');
                            case 'News Settings':
                              return const Text(
                                  'Adjust the news text, theme and more');
                          }
                        }(),
                        trailing: <Widget>() {
                          switch (entries[index].key) {
                            case 'Safe Mode':
                              return Switch(onChanged: (isOn) {}, value: false);
                            case 'GeoLocation':
                              return Switch(onChanged: (isOn) {}, value: false);
                            case 'Hide Nominal':
                                return Switch(onChanged: (isOn) {}, value: false);
                            case 'Fingerprint Sensor':
                                return Switch(onChanged: (isOn) {}, value: false);
                            default:
                              return null;
                          }
                        }(),
                        onTap: () {},
                        hoverColor: Colors.grey,
                      );
                    },
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'You will be Sign Out of all Applications'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      // await googleServices.signOutFromGoogle();
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    },
                                    child: const Text('Sign Out'))
                              ],
                            );
                          });
                    },
                    child: const Text('Sign Out',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 23,
                            fontWeight: FontWeight.bold))))
          ],
        ),
      ),
    );
  }
}
