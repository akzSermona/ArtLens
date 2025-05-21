import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/models/artwork.dart';

class UserFavoritesNotifier extends StateNotifier<List<Artwork>> {
  UserFavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final all = await ArtworkDb.instance.getAllArtworks();
    state = all.where((a) => a.isFavorite).toList();
  }

  Future<void> addToFavorites(Artwork artwork) async {
    await ArtworkDb.instance.addToFavorites(artwork.id);
    state = [...state, artwork];
  }

  Future<void> removeFromFavorites(Artwork artwork) async {
    await ArtworkDb.instance.removeFromFavorites(artwork.id);
    state = state.where((a) => a.id != artwork.id).toList();
  }

  bool isFavorite(Artwork artwork) {
    return state.any((a) => a.id == artwork.id);
  }
}

final favoritesProvider =
    StateNotifierProvider<UserFavoritesNotifier, List<Artwork>>(
      (ref) => UserFavoritesNotifier(),
    );
