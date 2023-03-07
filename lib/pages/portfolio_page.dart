import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyek_6/blocs/notes_bloc/notes_bloc.dart';
import 'package:proyek_6/models/notes.dart';
import 'package:proyek_6/pages/add_notes.dart';
import 'package:proyek_6/pages/markets_page.dart';

import '../blocs/portfolio_bloc/portfolios_bloc.dart';



class PortfolioPage extends StatefulWidget{
 const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> with SingleTickerProviderStateMixin {
  
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(vsync: this, length : 2, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex(){
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          title : const Text('Portfolios', style : TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom :  TabBar(
            labelColor: Colors.black,
            controller: _tabController,
            indicatorColor: Colors.black,
            tabs: [
            Container(padding : const EdgeInsets.all(10),
            child: const Text('Your Portfolios', 
            style: TextStyle(fontSize: 18 ),)
            ),
            Container(padding : const EdgeInsets.all(10),
             child: const Text('Your Notes',
                        style: TextStyle(fontSize: 18))
                        )


          ],)
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
          BlocBuilder<PortfoliosBloc, PortfoliosState>(
            builder: (context, state) {
              if (state is PortfoliosLoaded){
                return ListView.builder(
                  itemCount: state.portfolios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading : IconButton(
                        onPressed: (){
                        
                          // context.read<PortfoliosBloc>().add(DeletePortfolios(portfolios: state.portfolios[index]));
                        },
                        icon : const Icon(Icons.delete)
                      ),
                      title : Text(state.portfolios[index].name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      trailing : Column(
                        children: [
                          Text(state.portfolios[index].totalPrice.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(state.portfolios[index].change.toStringAsFixed(2),
                              style:  TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold, 
                                  color : (state.portfolios[index].change < 0.0) ?
                                  Colors.red : Colors.green
                                  ))
                        ],
                      ),
                      subtitle: Text(state.portfolios[index].lots.toString(),
                          style: const TextStyle(
                               fontWeight: FontWeight.bold, color : Colors.black)),
                    );
                  },
                );
              }
              else if(state is PortfoliosInitial){
                return const Center(child: CircularProgressIndicator());
              }
              else {
                return const Center(child : Text("There was an Error"));
              }
            },
          ),
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoaded){
                return ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index){
                   
                   Note note = state.notes[index];
                    return Container(
                      height : MediaQuery.of(context).size.height * 0.2,
                      padding : const EdgeInsets.all(8),
                      child : Card(
                        color : Colors.grey[300],
                        child: Container(
                          padding : const EdgeInsets.all(10),
                          child: Column(
                          
                             children : [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(note.title, style : const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                                ),
                              const SizedBox(height: 5,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(note.description,
                                style : const TextStyle(fontSize: 18)               
                                ),       
                                ),
    
                              Align(
                                alignment: Alignment.bottomRight,
                                child : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: (){
                                        context.read<NotesBloc>().add(DeleteNotes(note: note));
                                      },
                                    ),
    
                                      IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotesPage(notes : note.title, description: note.description,)));
                                              context.read<NotesBloc>().add(UpdateNotes(note: note));
                                            },
                                          )
                                ],)
                              )
                             ]
                          ),
                        ),
                      )
                    );
                  },
                );
              }
              else if(state is NotesLoading){
                return const Center(child: CircularProgressIndicator());
              }
              
            else {
               return const Center(child: Text('There was an Error', style : TextStyle(fontSize: 40)));
            }   
             
              
            },
          )
        ]),
       floatingActionButton: (_tabController.index == 0) ? FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => MarketsPage()));
       }, child : const FaIcon(FontAwesomeIcons.plus)) : FloatingActionButton(
            backgroundColor: Colors.black,
                foregroundColor: Colors.white,
        child : const FaIcon(FontAwesomeIcons.noteSticky),
        onPressed: (){
          Navigator.of(context).pushNamed('/addNotes');
        },
       ) 
      );
  }
}