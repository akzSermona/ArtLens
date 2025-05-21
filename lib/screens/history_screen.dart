import 'package:flutter/material.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/widgets/artwork_list/artwork_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isSearching = false;
  String _searchQuery = '';
  List<Artwork> _searchResults = [];
  List<Artwork> _allArtworks = [];
  bool _hasSearched = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAllArtworks();
  }

  Future<void> _loadAllArtworks() async {
    final artworks = await ArtworkDb.instance.getAllArtworks();
    setState(() {
      _allArtworks = artworks;
    });
  }

  Future<void> _performSearch(String query) async {
    final results = await ArtworkDb.instance.searchArtworks(query);
    setState(() {
      _searchResults = results;
      _hasSearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Cerca titolo opera o autore...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (query) {
                    _searchQuery = query;
                    _performSearch(query);
                  },
                )
                : const Text(
                  'Storia delle tue scansioni',
                  style: TextStyle(fontFamily: 'Limelight', fontSize: 18),
                ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchResults.clear();
                  _searchController.clear();
                  _hasSearched = false;
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body:
          _isSearching
              ? (_hasSearched
                  ? (_searchResults.isEmpty
                      ? const Center(child: Text('Nessun risultato'))
                      : ArtworkList(
                        artworks: _searchResults,
                        showOnlyFavorites: false,
                      ))
                  : Container())
              : ArtworkList(artworks: _allArtworks, showOnlyFavorites: false),
    );
  }
}
