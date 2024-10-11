class SearchQuery {
}

class SearchQueryCity extends SearchQuery {
  final String city;

  SearchQueryCity(this.city);
}

class SearchQueryCords extends SearchQuery {
  final double latitude;
  final double longitude;

  SearchQueryCords(this.latitude, this.longitude);
}

