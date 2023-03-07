import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:proyek_6/blocs/notes_bloc/notes_bloc.dart';
import 'package:proyek_6/blocs/portfolio_bloc/portfolios_bloc.dart';
import 'package:proyek_6/data.dart';
import 'package:proyek_6/pages/add_notes.dart';
import 'package:proyek_6/pages/home.dart';
import 'package:proyek_6/pages/login_page.dart';
import 'package:proyek_6/pages/markets_page.dart';
import 'package:proyek_6/pages/news_page.dart';
import 'package:proyek_6/pages/portfolio_page.dart';
import 'package:proyek_6/pages/profile_page.dart';
import 'package:proyek_6/providers/search_bar_provider.dart';
import 'package:proyek_6/providers/user_state_provider.dart';
import 'package:proyek_6/services/notification_service.dart';
import 'package:proyek_6/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/bottom_bar_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  await NotificationService.initNotifcations();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteRepos noteRepos = NoteRepos();
  MyApp({Key? key}) : super(key: key);

  Future<String?>? getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: noteRepos,
        ),
        RepositoryProvider.value(value: PortfolioRepos()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotesBloc>(
            create: (context) =>
                NotesBloc(noteRepos: noteRepos)..add(const ShowNotes()),
          ),
          BlocProvider(
            create: (context) => PortfoliosBloc()..add(const ShowPortfolios()),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<BottomBarProvider>(
              create: (context) => BottomBarProvider(),
            ),
            ChangeNotifierProvider<SearchBarProvider>(
              create: (context) => SearchBarProvider(),
            ),
            ChangeNotifierProvider<UserStateProvider>(
                create: (context) => UserStateProvider())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Inter'),
            initialRoute: (getEmail() != null) ? '/' : '/login',
            routes: {
              '/': (context) => MainPage(),
              '/login': (context) => LoginPage(),
              '/addNotes': (context) => AddNotesPage(),
            },
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final List<Widget> widgets = [
    HomePage(),
    MarketsPage(),
    PortfolioPage(),
    NewsPage(),
    MePage()
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomBarProvider>(context);

    return Scaffold(
      body: widgets[provider.index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          provider.navPageIndex = index;
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: provider.index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: bottomNavItems.entries.map<BottomNavigationBarItem>((e) {
          return BottomNavigationBarItem(
            icon: e.value,
            label: e.key,
          );
        }).toList(),
      ),
    );
  }
}
