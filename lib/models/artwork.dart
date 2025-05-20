import 'dart:convert';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;

  Map<String, dynamic> toMap() {
    return {'latitude': latitude, 'longitude': longitude, 'address': address};
  }

  factory PlaceLocation.fromMap(Map<String, dynamic> map) {
    return PlaceLocation(
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
    );
  }
}

class Artwork {
  Artwork({
    required this.title,
    required this.artist,
    required this.date,
    required this.description,
    required this.imagePath,
    required this.location,
    required this.informationLink,
    this.isFavorite = false,
    int? timestamp,
    String? id,
  }) : id = id ?? uuid.v4(),
       timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;

  final String id;
  final String title;
  final String artist;
  final String date;
  final String description;
  final String imagePath;
  final PlaceLocation location;
  final String informationLink;
  final int timestamp;
  bool isFavorite;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'date': date,
      'description': description,
      'imagePath': imagePath,
      'location': jsonEncode(location.toMap()),
      'informationLink': informationLink,
      'timestamp': timestamp,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Artwork.fromMap(Map<String, dynamic> map) {
    return Artwork(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      date: map['date'],
      description: map['description'],
      imagePath: map['imagePath'],
      location: PlaceLocation.fromMap(jsonDecode(map['location'])),
      informationLink: map['informationLink'],
      timestamp: map['timestamp'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  @override
  String toString() {
    return 'Opera d\'arte: $title\n'
        'Artista: $artist\n'
        'Anno: $date\n'
        'Descrizione: $description\n'
        'Immagine: $imagePath\n'
        'Luogo: $location\n'
        'Link: $informationLink\n';
  }
}
