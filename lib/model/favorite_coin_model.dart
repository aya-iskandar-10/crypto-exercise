import 'package:cloud_firestore/cloud_firestore.dart';

/// Typed model for one favorite (used with withConverter below).
class FavoriteCoin {
  const FavoriteCoin({
    required this.coinId,
    required this.name,
    required this.symbol,
    required this.priceWhenAdded,
    this.note = '',
    this.tags = const [],
    this.addedAt,
  });

  final String coinId; // = document id
  final String name;
  final String symbol;
  final double priceWhenAdded;
  final String note;
  final List<String> tags;
  final Timestamp? addedAt; // null until the server timestamp is written

  factory FavoriteCoin.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snap,
    SnapshotOptions? options,
  ) {
    final data = snap.data()!;
    return FavoriteCoin(
      coinId: snap.id,
      name: data['name'] as String,
      symbol: data['symbol'] as String,
      priceWhenAdded: (data['priceWhenAdded'] as num).toDouble(),
      note: data['note'] as String? ?? '',
      tags: List<String>.from(data['tags'] as List? ?? const []),
//      addedAt: (data['addedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'name': name,
    'symbol': symbol,
    'priceWhenAdded': priceWhenAdded,
    'note': note,
    'tags': tags,
    // addedAt is written with FieldValue.serverTimestamp() on create
  };
}
