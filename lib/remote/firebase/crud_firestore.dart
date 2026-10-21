import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_exercice/model/favorite_coin_model.dart';

class FirestoreCrud {
  FirestoreCrud(this.uid, {FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  final String uid;
  final FirebaseFirestore _db;

  // ---------- references ----------
  CollectionReference<Map<String, dynamic>> get favoritesRaw =>
      _db.collection('users').doc(uid).collection('favorites');

  /// withConverter: every read returns FavoriteCoin, every write takes one.
  CollectionReference<FavoriteCoin> get favorites => favoritesRaw.withConverter(
    fromFirestore: FavoriteCoin.fromFirestore,
    toFirestore: (fav, _) => fav.toFirestore(),
  );

  DocumentReference<Map<String, dynamic>> coinStats(String coinId) =>
      _db.collection('coins').doc(coinId);
}
