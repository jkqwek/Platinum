import 'package:flutter/material.dart';
import '../widgets/game_card.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _searchQuery = '';
  String _selectedStatus = 'All';

  final List<String> _statuses = ['All', 'Completed', 'Playing', 'Not Started'];

  final List<Map<String, String>> _allGames = [
    {'title': 'Elden Ring', 'hours': '125 h', 'status': 'Completed'},
    {'title': 'Cyberpunk 2077', 'hours': '85 h', 'status': 'Completed'},
    {'title': 'The Witcher 3', 'hours': '120 h', 'status': 'Playing'},
    {'title': 'Hades', 'hours': '45 h', 'status': 'Completed'},
    {'title': 'Baldur\'s Gate 3', 'hours': '90 h', 'status': 'Playing'},
    {'title': 'Stardew Valley', 'hours': '60 h', 'status': 'Not Started'},
    {'title': 'Red Dead Redemption 2', 'hours': '110 h', 'status': 'Completed'},
    {'title': 'Skyrim', 'hours': '200 h', 'status': 'Playing'},
  ];

  List<Map<String, String>> get _filteredGames {
    return _allGames.where((game) {
      final matchesSearch = game['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesStatus = _selectedStatus == 'All' || game['status'] == _selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Library',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search games...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _statuses.map((status) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(status),
                      selected: _selectedStatus == status,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = status;
                        });
                      },
                      backgroundColor: const Color(0xFF1E1E1E),
                      selectedColor: const Color(0xFF64B5F6).withOpacity(0.2),
                      checkmarkColor: const Color(0xFF64B5F6),
                      labelStyle: TextStyle(
                        color: _selectedStatus == status ? const Color(0xFF64B5F6) : Colors.white70,
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredGames.isEmpty
                  ? const Center(
                      child: Text(
                        'No games found',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 245,
                      ),
                      itemCount: _filteredGames.length,
                      itemBuilder: (context, index) {
                        final game = _filteredGames[index];
                        return GameCard(
                          title: game['title']!,
                          hours: game['hours']!,
                          imageUrl: null,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: const Color(0xFF64B5F6),
        child: const Icon(Icons.add),
      ),
    );
  }
}