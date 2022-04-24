import 'package:flutter/material.dart';

import '../../domain/entities/league_entity.dart';
import 'league_widget.dart';

class LeagueListWidget extends StatefulWidget {
  final List<League> leagues; 
  const LeagueListWidget({ 
    required this.leagues, 
    Key? key 
  }) : super(key: key);

  @override
  State<LeagueListWidget> createState() => _LeagueListWidgetState();
}

class _LeagueListWidgetState extends State<LeagueListWidget> {
  late final TextEditingController _searchController; 
  late List<League> _displayedLeagues; 

  @override
  void initState() {
    _searchController = TextEditingController(); 
    _displayedLeagues = widget.leagues; 
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose(); 
    super.dispose();
  }

  void _updateSearch() {
    final searchQuery = _searchController.text.toLowerCase(); 
    final filteredLeagues = widget.leagues
      .where((league) => 
        league.title.toLowerCase().contains(searchQuery)
      )
      .toList(); 
    setState(() {
      _displayedLeagues = filteredLeagues;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (_) => _updateSearch(),
                decoration: const InputDecoration(
                  label: Text("Enter the League name"), 
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _searchController.clear(); 
                  _updateSearch();
                }, 
                child: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Clear", textScaleFactor: 1.6,),
                )
              ),
            )
          ],
        ),
      ), 
      Expanded(
        child: ListView.builder(
          itemCount: _displayedLeagues.length, 
          itemBuilder: (context, index) => LeagueWidget(league: _displayedLeagues[index])
        ),
      ),
    ]);
  }
}