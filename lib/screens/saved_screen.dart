import 'package:artlens/widgets/artwork_list/artwork_list.dart';
import 'package:flutter/material.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/models/artwork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  bool _isSearching = false;
  List<Artwork> _searchResults = [];
  bool _hasSearched = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final results = await ArtworkDb.instance.searchFavoriteArtworks('');
    setState(() {
      _searchResults = results;
      _hasSearched = true;
    });
  }

  Future<void> _performSearch(String query) async {
    final results = await ArtworkDb.instance.searchFavoriteArtworks(query);
    setState(() {
      _searchResults = results;
      _hasSearched = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    _performSearch(query);
                  },
                )
                : Text(
                  'Le tue scansioni salvate',
                  style: TextStyle(fontFamily: 'Limelight', fontSize: 18.r),
                ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _searchResults.clear();
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
          _hasSearched
              ? (_searchResults.isEmpty
                  ? const Center(child: Text('Nessun risultato'))
                  : ArtworkList(
                    artworks: _searchResults,
                    showOnlyFavorites: true,
                  ))
              : Container(),
    );
  }
}
