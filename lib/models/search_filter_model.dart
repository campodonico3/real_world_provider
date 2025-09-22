enum SearchFilter { all, restaurants, products }

class SearchResult {
  final SearchResultType type;
  final String id;
  final String name;
  final String? imageUrl;
  final double? rating;
  final String? subtitle;

  const SearchResult({
    required this.type,
    required this.id,
    required this.name,
    this.imageUrl,
    this.rating,
    this.subtitle,
  });
}

enum SearchResultType { restaurant, product }
